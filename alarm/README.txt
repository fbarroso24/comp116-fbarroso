Filipe Barroso
10/07/14
Computer Security 116
Assignment #2: Incident Alarm with Ruby and PacketFu

README.txt
Identify what aspects of the work have been correctly implemented and what have not.
	Implemented
    1. Analyze a live stream of network packets for the following incidents:
		1. Null scan (http://nmap.org/book/man-port-scanning-techniques.html)
		2. Xmas scan (http://nmap.org/book/man-port-scanning-techniques.html)
		3. Credit card number leaked in the clear via website
			Example) http://support.microsoft.com/kb/258255
			
		NOTE: It will print an alert for each incident detected. (e.g For a Null scan,
		this can mean many Null scan alerts from the same source IP.)
		
	2. Analyze Web Server Log for the following incidents
		1. Shellcode
		2. NMAP scan (http://nmap.org/book/man-port-scanning-techniques.html)
		3. HTTP errors (anything with HTTP status code in the 400-range)
		
		NOTE: If multiple incidents occurred in the same request, only ONE alert 
		is printed (in the order above)


Identify anyone with whom you have collaborated or discussed the assignment.
	I spoke with the professor and asked some questions on Piazza
	
Say approximately how many hours you have spent completing the assignment.
	15 Hours

Are the heuristics used in this assignment to determine incidents "even that good"?
	They make assumptions like the credit card numbers must be a 16 or 15 digit number starting with either
	4, 5, 6011, or 3 to represent the following credit cards (Visa, Mastercard, Discover, or American Express) respectively.
	However, its possible that we run into false alarm since we'd be naive to think that all 16 digit numbers starting with
	4 represent Visa credit card numbers.  The same holds true for the other credit cards.
	
	In general, I would say they are decent but have the possibility to encounter false-positives
	
	
If you have spare time in the future, what would you add to the program or do differently with regards to detecting incidents?
     I would allow the user to input additional parameters in order to be more specific in the types of incidents they are looking for.
	 This would allow them to narrow down the types of incidents they are trying to investigate.  
	 Additional features might include saving the report to a file or even emailing the user a report.