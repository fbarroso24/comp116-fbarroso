Filipe Barroso
11/13/14
Computer Security 116
Assignment #4: Technical Risk Analysis

     In this assignment, we had to perform a technical risk analysis on the CTF 
game from assignment #3. In order to analyze it, I ran a static analysis scan
using the Veracode website (https://analysiscenter.veracode.com).  When setting
the scan policy, I chose the strictest settings in hopes that it
would return the most vulnerabilities.  My technical risk analysis contains
vulnerabilities directly in the CTF source code as well as 3rd-party software.
I decided to include both since a vulnerability in 3rd-party software can still
result in a vulnerability for any other software that leverages it (e.g. CTF). 

DIRECTORY CONTENTS
CTF2014_RiskReport.pdf - The file containing my technical risk analysis.
DetailedReport_Comp116_CTF_2014_7_Nov_2014.pdf - The results of the Veracode static analysis scan.
ctf2014.zip - The source code to be scanned and analyzed.

