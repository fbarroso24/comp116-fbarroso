Filipe Barroso & Robert Lasell
12/04/14
Comp 116: Security
Homework 5: Forensics

Question 1:
Image B is smaller than the others.  Image B is 89 KB while images A & C are 95 kb.
 If you run steghide extract -sf b.jpg -p <passwd> on the image it will produce a runme file.
 If you then make the file an executable and run it (i.e ./runme Rob) it will display
 
      Rob, you are doing a heckuvajob tp to this point!

Question 2:
1) What is/are the disk format(s) of the disk on the suspect's computing device?
	Win95 FAT32  1-125000
	Linux ext 125001-6143999

2) Is there a phone carrier involved?
	No, there is not
	
3) What operating system, including version number, is being used? Please elaborate how you determined this information.
	Kali GNU/Linux 1.0.9
	
	How Found:
	     Using autopsy, we navigated to the /etc/issue file and found the OS & version number

4) What applications are installed on the disk? Please elaborate how you determined this information.
	Kali Linux Security Applications
	
	How Found:
	     Navigate to /usr/sbin and you can see all the applications installed there within.
		 
5) Is there a root password? If so, what is it?
	root:princess
	
	How Found:
		We combined /etc/passwd & /etc/shadow files into a single file and then used john the ripper to crack the password.
		We used the burnett_top_500.txt wordlist file that is included in kali linux distribution.
		
6) Are there any additional user accounts on the system? If so, what are their passwords?
	stefani:iloveyou
	alejandro:pokerface
	judas:00000000
	
	We combined the /etc/passwd & /etc/shadow files into 1 file and then used john the ripper to brute force the passwords using wordlists.
	
7) List some of the incriminating evidence that you found. Please elaborate where and how you uncovered the evidence.
	
	1) We found a list of her upcoming performances in /home/stefani/sched.txt  including:
	    12/31/2014: The Chelsea at the Cosmopolitan of Las Vegas Las Vegas, NV 9:00 p.m. PST
		2/8/2015: Wiltern Theatre, Los Angeles, CA, 9:30 p.m. PST
		5/30/2015: Hollywood Bowl, Hollywood, CA, 7:30 p.m. PDT
	2) They tried to remove 3 pics (a15.jpg, a16.jpg, & a17.jpg)
	    You can see this if you look in /home/alejandro/.bash_history
	3) There is a ringtone located in /home/alejandro/ringtone.mp3
	4) Video of her perfomance. vintage_nyu_performance.mp4 file
	5) edge.mp4 was encrypted inside of lockbox.txt
	
8) Did the suspect move or try to delete any files before his arrest? Please list the name(s) of the file(s) and any indications of their contents that you can find.
	a15.jpg  
	a16.jpg
	a17.jpg
	
	All of these files have the following file permissions (rw-r-----)   usr/group/others
	This leads us to believe that they were private to the user as the permissions for 'others' did not have read access.
	This leads us to believe that the suspect wanted to ensure these files remained private.
	
9) Did the suspect save pictures of the celebrity? If so, how many pictures of the celebrity did you find? (including any deleted images)
	/home/alejandro has 17 pictures of Lady Gaga, 3 of which were deleted (a15.jpg, a16.jpg, & a17.jpg)
		
10) Are there any encrypted files? If so, list the contents and a brief description of how you obtained the contents.
	Yes, lockbox.txt is encrypted.  

	In order to obtain the contents of the file, we did the following:
	     1) file lockbox.txt 
		    lockbox.txt: Zip archive data, at least v2.0 to extract
		 2) unzip lockbox.txt
			Archive:  lockbox.txt
			[lockbox.txt] edge.mp4 password: gaga
		 3) This produced an edge.mp4 file which has an interview she conducted with Howard Stern
	
11) Do the suspect want to go see this celebrity? If so, note the date(s) and location(s) where the suspect want see to the celebrity.
	Yes. The dates are as follows:
		12/31/2014: The Chelsea at the Cosmopolitan of Las Vegas Las Vegas, NV 9:00 p.m. PST
		2/8/2015: Wiltern Theatre, Los Angeles, CA, 9:30 p.m. PST
		5/30/2015: Hollywood Bowl, Hollywood, CA, 7:30 p.m. PDT
	
12) Who is the celebrity that the suspect has been stalking?
	Lady Gaga - Joanne Stefani Germanotta