package com.neil.ecoblue.controller;

import com.neil.ecoblue.model.*;
import com.neil.ecoblue.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
public class EcoblueRestController {


    @Autowired
    AccountRepository accountRepository;
    @Autowired
    RedeemRepository redeemRepository;
    @Autowired
    ItemRepository itemRepository;
    @Autowired
    TransactionRepository transactionRepository;
    @Autowired
    PasswordRepository passwordRepository;

    @PostMapping("/checkuser")
    public String checkUser(HttpServletRequest request){
        return(accountRepository.findByEmail(request.getParameter("user")+"@iacademy.edu.ph")==null?"invalid":"valid");
    }
    @PostMapping("/checkredeem")
    public String checkRedeem(HttpServletRequest request){
        Account acc = accountRepository.findByEmail(request.getParameter("user")+"@iacademy.edu.ph");
        return(acc==null?"invalid":Double.toString(acc.getTotalPoints()));
    }

    @PostMapping("/updateItem")
    public String updateItem(HttpServletRequest request){
        Item item = itemRepository.findByItemId(Integer.parseInt(request.getParameter("itemId")));
        item.setItemName(request.getParameter("itemName"));
        item.setItemPoint(Double.parseDouble(request.getParameter("itemPoint")));
        item.setPhpValue(Double.parseDouble(request.getParameter("phpValue")));
        itemRepository.save(item);
        return item.getItemName();
    }

    @PostMapping("/updateAccount")
    public String updateAccount(HttpServletRequest request){
        Account account = accountRepository.findByAccountId(Integer.parseInt(request.getParameter("accountId")));
        account.setEmail(request.getParameter("email"));
        account.setFirstName(request.getParameter("accountName"));
        accountRepository.save(account);
        return account.getEmail();
    }

    @PostMapping("/updateRedeem")
    public String updateRedeem(HttpServletRequest request){
        Redeem redeem = redeemRepository.findByRedeemId(Integer.parseInt(request.getParameter("redeemId")));
        redeem.setRedeemName(request.getParameter("redeemName"));
        redeem.setRedeemValue(Double.parseDouble(request.getParameter("redeemValue")));
        redeemRepository.save(redeem);
        return redeem.getRedeemName();
    }

    @PostMapping("/updatePassword")
    public int updatePassword(HttpServletRequest request){
        Password password = passwordRepository.findByPasswordId(0);
        password.setPassword(request.getParameter("password"));
        passwordRepository.save(password);
        return password.getPasswordId();
    }

    @PostMapping("/deleteItem")
    public String deleteItem(HttpServletRequest request){
        Item item = itemRepository.findByItemId(Integer.parseInt(request.getParameter("itemId")));
        itemRepository.delete(itemRepository.findByItemId(Integer.parseInt(request.getParameter("itemId"))));
        return item.getItemName();
    }

    @PostMapping("/deleteAccount")
    public String deleteAccount(HttpServletRequest request){
        Account account = accountRepository.findByAccountId(Integer.parseInt(request.getParameter("accountId")));
        List<Transaction> transactionList = transactionRepository.findByAccountAccountId(Integer.parseInt(request.getParameter("accountId")));
        transactionList.stream().forEach(transactionRepository::delete);
        accountRepository.delete(account);
        //System.out::println = System.out.println(transaction);
        //transactionRepository::delete = transactionRepository.delete(transaction)
        return account.getEmail();
    }

    @PostMapping("/deleteRedeem")
    public String deleteRedeem(HttpServletRequest request){
        Redeem redeem = redeemRepository.findByRedeemId(Integer.parseInt(request.getParameter("redeemId")));
        redeemRepository.delete(redeemRepository.findByRedeemId(Integer.parseInt(request.getParameter("redeemId"))));
        return redeem.getRedeemName();
    }


}
