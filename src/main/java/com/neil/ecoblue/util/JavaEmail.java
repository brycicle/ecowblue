package com.neil.ecoblue.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.neil.ecoblue.model.Account;
import com.neil.ecoblue.model.Item;
import com.neil.ecoblue.model.Redeem;
public class JavaEmail implements Runnable{
	
	Properties emailProperties;
	Session mailSession;
	MimeMessage emailMessage;
	private Account account;
	private Object item;
	private int qty;
	private int emailType;

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public Object getItem() {
		return item;
	}

	public void setItem(Object item) {
		this.item = item;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public int getEmailType() {
		return emailType;
	}

	public void setEmailType(int emailType) {
		this.emailType = emailType;
	}

	@Override
	public void run() {
		this.account = account;
		this.item = item;
		this.qty = qty;
		setMailServerProperties();
		try {
			createEmailMessage(emailType);
			sendEmail();
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}


	public void sendEmail2(Account account, Object item, int qty, int emailType) throws AddressException, MessagingException {
		this.account = account;
		this.item = item;
		this.qty = qty;
		setMailServerProperties();
		createEmailMessage(emailType);
		sendEmail();
	}

	public void setMailServerProperties() {

		String emailPort = "587";//gmail's smtp port

		emailProperties = System.getProperties();
		emailProperties.put("mail.smtp.port", emailPort);
		emailProperties.put("mail.smtp.auth", "true");
		emailProperties.put("mail.smtp.starttls.enable", "true");

	}

	public void createEmailMessage(int emailType) throws AddressException,
			MessagingException {
		String toEmails = "201501285@iacademy.edu.ph";
		//String toEmails = account.getEmail();
		String emailSubject="";
		String emailBody="";
		if(emailType==0) {
			Item convertItem = (Item)item;
			emailSubject = "Ecoblue Transaction - Convert";
			emailBody = "Item name: " + convertItem.getItemName() + "<br>" 
					+ "Item point: " + convertItem.getItemPoint() + "<br>"
					+ "No. of item: " + String.valueOf(qty) + "<br>"
					+ "Total points earned: " + String.valueOf(qty*convertItem.getItemPoint()) + "<br>"
					+ "Your total points: " + account.getTotalPoints() + "<br>"
					+ "Thank you for recycling!";
		}else if(emailType==1) {
			Redeem redeemItem = (Redeem)item;
			emailSubject = "Ecoblue Transaction - Redeem";
			emailBody = "Item name: " + redeemItem.getRedeemName() + "<br>" 
					+ "Item point: " + redeemItem.getRedeemValue() + "<br>"
					+ "No. of item: " + String.valueOf(qty) + "<br>"
					+ "Total points spent: " + String.valueOf(qty*redeemItem.getRedeemValue()) + "<br>"
					+ "Your total points: " + account.getTotalPoints() + "<br>"
					+ "Thank you for recycling!";
		}
		

		mailSession = Session.getDefaultInstance(emailProperties, null);
		emailMessage = new MimeMessage(mailSession);

		emailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmails));

		emailMessage.setSubject(emailSubject);
		emailMessage.setContent(emailBody, "text/html");//for a html email
		//emailMessage.setText(emailBody);// for a text email

	}

	public void sendEmail() throws AddressException, MessagingException {

		String emailHost = "smtp.gmail.com";
		String fromUser = "ecoblue@iacademy.edu.ph";//just the id alone without @gmail.com
		String fromUserEmailPassword = "blue2019";

		Transport transport = mailSession.getTransport("smtp");

		transport.connect(emailHost, fromUser, fromUserEmailPassword);
		transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
		transport.close();
		System.out.println("Email sent successfully.");
	}

}
