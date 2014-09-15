Filipe Barroso
Assignment 1: Packet Sleuth
Due: Tuesday, September 16th 2014 at 11:59 PM

set1.pcap

1. How many packets are there in this set?
	1503 packets

2. What protocol was used to transfer files from PC to server?
	FTP

3. Briefly describe why the protocol used to transfer the files is insecure?
	FTP doesn't encrypt its traffic.  It sends information (usernames, passwords, etc.) in
	clear text which is a security vulnerability.

4. What is the secure alternative to the protocol used to transfer files?
	SFTP - Secure File Transfer Protocol
	
5. What is the IP address of the server?
	67.23.79.113

6. What was the username and password used to access the server?
	USER: ihackpineapples
	PASSWORD: rockyou1
	
7. How many files were transferred from PC to server?
	4 files
	
8. What are the names of the files transferred from PC to server?
	BjN-O1hCAAAZbiq.jpg
	BvgT9p2IQAEEoHu.jpg
	BvzjaN-IQAA3XG7.jpg
	smash.txt
	
9. Extract all the files that were transferred from PC to server. These files must be part of your submission!
	(See attached files)
	
set2.pcap

10. How many packets are there in this set?
	77,882

11. How many plaintext username-password pairs are there in this packet set?
	Two:
		1) USER: 1 PASS: 
		2) USER: chris@digitalinterlude.com PASS: Volrathw69
		
12. Briefly describe how you found the username-password pairs.
	I ran the following command as root superuser:
		ettercap -T -r set2.pcap | grep "PASS:"
		
13. For each of the plaintext username-password pair that you found, identify the protocol used, server IP, the corresponding domain name (e.g., google.com), and port number.
		1) Protocol: HTTP, 
		   Server IP: 75.126.96.187
		   Domain: defcon-wireless-village.com
		   Port: 80
		   
		2) Protocol: POP3, 
		   Server IP: 75.126.75.131
		   Domain: mail.si-sv3231.com
		   Port: 110
	
IMPORTANT NOTE: PLEASE DO NOT LOG ON TO THE WEBSITE OR SERVICE ASSOCIATED WITH THE USERNAME-PASSWORD THAT YOU FOUND!

14. Of all the plaintext username-password pairs that you found, how many of them are legitimate? That is, the username-password was valid, access successfully granted?
		Only chris@digitalinterlude/Volrathw69 is valid.
		
15. How did you verify the successful username-password pairs?
		Using wireshark, you can 'Follow TCP Stream'.  Then you can see that the password was accepted successfully. (OK Password OK)
		
16. What advice would you give to the owners of the username-password pairs that you found so their account information would not be revealed "in-the-clear" in the future?
		I would suggest they avoid using email accounts that use POP & IMAP since they send information 'in-the-clear' and instead try to take advantage of email accounts
		using PGP (Pretty Good Protection) or S/MIME (Secure/Multipurpose Internet Mail Extensions) since those protocols use encryption to send their information.