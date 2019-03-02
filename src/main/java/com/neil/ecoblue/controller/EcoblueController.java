package com.neil.ecoblue.controller;

import com.neil.ecoblue.model.Account;
import com.neil.ecoblue.model.Item;
import com.neil.ecoblue.model.Redeem;
import com.neil.ecoblue.model.Transaction;
import com.neil.ecoblue.repository.AccountRepository;
import com.neil.ecoblue.repository.ItemRepository;
import com.neil.ecoblue.repository.RedeemRepository;
import com.neil.ecoblue.repository.TransactionRepository;
import com.neil.ecoblue.util.JavaEmail;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@Controller()
public class EcoblueController {

    //siya bahala ng lahat ng Account sa database
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    ItemRepository itemRepository;
    @Autowired
    RedeemRepository redeemRepository;
    @Autowired
    TransactionRepository transactionRepository;

    //return lang sa index pag nagtype ng localhost:8080
    @GetMapping("/index")
    public ModelAndView loadPage(){
        ModelAndView mav = new ModelAndView();
        mav.addObject("items", itemRepository.findAll());
        mav.setViewName("index");
        return mav;
    }
    @GetMapping("/")
    public ModelAndView index(){
        ModelAndView mav = new ModelAndView();
        mav.addObject("items", itemRepository.findAll());
        mav.setViewName("index");
        return mav;
    }

    //logout----alam mo na yan
    @GetMapping("/logout")
    public ModelAndView logout(HttpSession session){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        mav.addObject("items", itemRepository.findAll());
        session.invalidate();
        return mav;
    }

    //Check if the user is already logged in when accessing the login url. or onclick on banner/brand    /// redirect to landing page
    @GetMapping("/login")
    public ModelAndView bannerClick(HttpSession session){
        return new ModelAndView("login");
    }

    //ididisplay lang form na pwede ka magconvert ng items to points
    @GetMapping("/convert")
    public ModelAndView showItems(HttpSession session){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        mav.addObject("items", itemRepository.findAll());
        return mav;
    }

    @GetMapping("/accounts")
    public ModelAndView showAccounts(HttpSession session){
        ModelAndView mav = new ModelAndView();
        Account account = (Account) session.getAttribute("account");
        if(account==null)
            mav.setViewName("index");
        else if(account.getType()==3)
            mav.setViewName("redeem");
        else {
            mav.setViewName("accounts");
            mav.addObject("accounts", accountRepository.findAll());
        }
        return mav;
    }
    //ididisplay lang form na pwede ka magredeem ng items gamit points
    @GetMapping("/redeem")
    public ModelAndView showRedeem(HttpSession session){
        ModelAndView mav = new ModelAndView();
        if(session.getAttribute("account")==null)
            mav.setViewName("login");
        else
            mav.setViewName("redeem");
        mav.addObject("items", redeemRepository.findAll());
        return mav;
    }

    @GetMapping("/history")
    public ModelAndView showHistory(HttpSession session){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("history");
        List<Transaction> list = transactionRepository.findAll();
        Collections.reverse(list);
        mav.addObject("list", list);
        return mav;
    }


    //dito pupunta pagkatapos mo i click yung convert button
    @PostMapping("/convert")
    public ModelAndView convertItems(HttpServletRequest request, HttpSession session) throws AddressException, MessagingException{
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index");
        List<Item> itemList = itemRepository.findAll();
        Account acc = accountRepository.findByEmail(request.getParameter("user")+"@iacademy.edu.ph");
        for(int x=0;x<itemList.size();x++){
            if(Integer.parseInt(request.getParameter("item-"+x))!=0){
                Item item = itemRepository.findByItemId(itemList.get(x).getItemId());
                int qty = Integer.parseInt(request.getParameter("item-"+x));
                acc.setTotalPoints(acc.getTotalPoints() + item.getPhpValue()*qty);
                accountRepository.save(acc);
                transactionRepository.save(new Transaction(acc,item,qty,item.getPhpValue()*qty));
                session.setAttribute("account", acc);
                JavaEmail javEmail = new JavaEmail();
                javEmail.setAccount(acc);
                javEmail.setQty(qty);
                javEmail.setItem(item);
                javEmail.setEmailType(0);
                Thread t1 =new Thread(javEmail);
                t1.start();
            }
            System.out.println();
        }
        mav.addObject("items", itemRepository.findAll());
        return mav;
    }
    @PostMapping("/newItem")
    public ModelAndView addItem(HttpServletRequest request, HttpSession session) throws AddressException, MessagingException{
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin");
        itemRepository.save(new Item(
                request.getParameter("itemName"),
                Integer.parseInt(request.getParameter("itemPoint")),
                Double.parseDouble(request.getParameter("phpValue"))));
        mav.addObject("items", itemRepository.findAll());
        mav.addObject("redeems", redeemRepository.findAll());
        return mav;
    }
    @PostMapping("/newRedeem")
    public ModelAndView newRedeem(HttpServletRequest request, HttpSession session) throws AddressException, MessagingException{
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin");
        redeemRepository.save(new Redeem(
                request.getParameter("redeemName"),
                Double.parseDouble(request.getParameter("redeemValue"))));
        mav.addObject("items", itemRepository.findAll());
        mav.addObject("redeems", redeemRepository.findAll());
        return mav;
    }

    @PostMapping("/uploadcsv")
    public ModelAndView uploadcsv(HttpServletRequest request, HttpSession session) throws Exception{
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin");

        String description = request.getParameter("description"); // Retrieves <input type="text" name="description">
        Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        InputStream fileContent = filePart.getInputStream();

        ArrayList<String> al = new ArrayList<String>();
        String thisLine = "";
        DataInputStream myInput = new DataInputStream(fileContent);
        while ((thisLine = myInput.readLine()) != null) {
            al = new ArrayList<String>();
            String strar[] = thisLine.split(",");
            String firstName="", lastName="", email="", password="";
            int type;
            for(int x=0;x<strar.length;x++){
                if(x==0)
                    email = strar[x];
                else
                    firstName += strar[x];
            }
            accountRepository.save(new Account(firstName,lastName,email,password,1,0));
            System.out.println(strar[0] + "\t" + strar[1]);
        }
        System.out.println("fileName"+fileName);
        System.out.println("fileContent"+fileContent);
        /*redeemRepository.save(new Redeem(
                request.getParameter("redeemName"),
                Double.parseDouble(request.getParameter("redeemValue"))));*/
        mav.addObject("items", itemRepository.findAll());
        mav.addObject("redeems", redeemRepository.findAll());
        return mav;
    }

    @PostMapping("/redeem")
    public ModelAndView redeemItems(HttpServletRequest request, HttpSession session) throws AddressException, MessagingException{
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redeem");
        List<Redeem> itemList = redeemRepository.findAll();
        Account acc = accountRepository.findByEmail(request.getParameter("user")+"@iacademy.edu.ph");
        for(int x=1;x<=itemList.size();x++) {
            if (Integer.parseInt(request.getParameter("item-" + x)) != 0) {
                Redeem redeem = redeemRepository.findByRedeemId(x);
                int qty = Integer.parseInt(request.getParameter("item-"+x));
                acc.setTotalPoints(acc.getTotalPoints() - (qty*redeem.getRedeemValue()));
                accountRepository.save(acc);
                transactionRepository.save(new Transaction(acc,redeem,qty,redeem.getRedeemValue()*qty));
                session.setAttribute("account", acc);
                JavaEmail javEmail = new JavaEmail();
                javEmail.setAccount(acc);
                javEmail.setQty(qty);
                javEmail.setItem(redeem);
                javEmail.setEmailType(1);
                Thread t1 =new Thread(javEmail);
                t1.start();
            }
        }
        mav.addObject("items", redeemRepository.findAll());
        return mav;
    }

    @PostMapping("/login")
    public ModelAndView login(@RequestParam(value = "email") String email, @RequestParam(value = "password") String password, HttpSession session){
        ModelAndView mav = new ModelAndView();
        //hanap ng match sa db gamit email at password
        Account account = accountRepository.findByEmailAndPassword(email+"@iacademy.edu.ph", password);
        session.setAttribute("admin",account);
        if(account==null) {
            mav.setViewName("login");
            mav.addObject("error","Incorrect Username/Password");
            return mav;
        }
        if(account.getType()==2){
            mav.setViewName("admin");
            mav.addObject("items", itemRepository.findAll());
            mav.addObject("redeems", redeemRepository.findAll());
            mav.addObject("accounts", accountRepository.findAll());
            session.setAttribute("account", account);
        }
        else if(account.getType()==3){
            mav.setViewName("redeem");
            mav.addObject("items", redeemRepository.findAll());
            session.setAttribute("account", account);
        }
        else
            return new ModelAndView("convert");
        return mav;
    }

}
