#!/usr/bin/env ruby
 
# Filipe Barroso
# 10/07/14
# Computer Security 116
# Assignment 2: Incident Alarm with Ruby and PacketFu

require 'packetfu'
require 'base64'

# Analyzes a live stream of network packets for the following incidents
#      1. NULL Scan
#      2. Xmas Scan
#      3. Credit card number leaked in the clear via website
# 	      Example) http://support.microsoft.com/kb/258255
def analyzeLive
	attackNum = 0
	
	# Go into permiscuous mode and start capturing live packets
	cap = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)
	cap.stream.each do |p|
		pkt = PacketFu::Packet.parse(p)
		protocol = pkt.protocol()
		
		# Check each TCP packet
		if (protocol.include? "TCP")
			protocol = "TCP"
			sourceIP = pkt.ip_saddr
			tcpFlags = pkt.tcp_flags
			payload = pkt.payload
			binData = Base64.encode64(payload)
			
			# Check for Xmas Scan, NULL Scan, or Credit card in that order
			if (tcpFlags.fin == 1 && tcpFlags.psh == 1 && tcpFlags.urg == 1)
				#puts "TCP FLAGS ARE #{tcpFlags}"		
				attackNum += 1
				puts "#{attackNum}. ALERT: Xmas scan is detected from #{sourceIP} (#{protocol}) (#{binData})!"
			elsif (tcpFlags.ack == 0 && tcpFlags.fin == 0 && tcpFlags.psh == 0 && 
					tcpFlags.rst == 0 && tcpFlags.syn == 0 && tcpFlags.urg == 0)
				#puts "TCP FLAGS ARE #{tcpFlags}"
				attackNum += 1
				puts "#{attackNum}. ALERT: NULL scan is detected from #{sourceIP} (#{protocol}) (#{binData})!"
			elsif (checkCreditCardLeak(payload) == true)
				# scan for credit card
				attackNum += 1
				protocol = "HTTP"
				puts "#{attackNum}. ALERT: Credit card leaked in the clear from #{sourceIP} (#{protocol}) (#{binData})!"
			end
		end
	end
end

# Reads a web server log and analyzes it for the following incidents:
#      1. Shellcode error
#      2. NMAP scan
#      3. HTTP Errors (i.e any HTTP status code in the 400-range)
def analyzeLog(logFile)
	attackNum = 0
	
	# Only analyze it if the file exists
	if File::exists?(logFile)
		File.foreach(logFile) do |line|
			if (line[/\"\\x.[0-9]\\/])
				# Log Shellcode error
				attackNum +=1
				printError(line, attackNum, "Shellcode", "HTTP")
			elsif (line[/Nmap/])
				# Log NMAP Scan error
				attackNum += 1
				printError(line, attackNum, "NMAP scan", "HTTP")
			elsif (line[/\" 4[0-9][0-9]/])
				# Log HTTP Error
				attackNum += 1
				printError(line, attackNum, "HTTP error", "HTTP")
			end
		end
	else
		puts "The file '#{logFile}' does not exist.  Please provide a valid file"
	end
end

# For info on credit card leaks visit: http://www.sans.org/security-resources/idfaq/snort-detect-credit-card-numbers.php
def checkCreditCardLeak(payload)
	visa = "4\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}"
	mastercard = "5\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}"
	discover = "6011(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}"
	amex = "3\d{3}(\s|-)?\d{6}(\s|-)?\d{5}"
	patterns = [visa, mastercard, discover, amex]
	
	patterns.each do |card| 
		hit = payload.scan(/#{card}/i)	
		if hit.size > 0
			return true
		end
	end
	return false
end

def printError(line, incident_number, attack, protocol)
	# Get source IP 
	ip_match = line.split(" ")
	sourceIP = ip_match[0].to_s
	
	# Get the payload being used
	payload_match = line.split("\"")
	payload = payload_match[1].to_s
	
	# ALERT: HTTP error is detected from 192.168.1.3 (HTTP) ("GET /phpMyAdmin/scripts/setup.php HTTP/1.1")!
	puts "#{incident_number}. ALERT: #{attack} is detected from #{sourceIP} (#{protocol}) (\"#{payload}\")!"
end

def printInvalidSyntax
	puts "Invalid syntax!!!"
	puts "Run 'sudo ruby alarm.rb' without any flags to analyze the live stream of network packets"
	puts "Run 'sudo ruby alarm.rb -r <web_server_log>' to analyze the web server log"
end

#MAIN
if ARGV.length == 0
	analyzeLive()
elsif ARGV.length == 2
	if (ARGV[0] <=> "-r") == 0
		analyzeLog(ARGV[1])
	else
		printInvalidSyntax()
	end
else
	printInvalidSyntax()
end