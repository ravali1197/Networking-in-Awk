#!/bin/bash
echo -n "Enter the filename : "
read name
more $name
echo ""
while((1))
do
	echo -e "------------------------------------------------------------------------------------------------------------\n"	
	echo ""
	echo -e "The choices available are - \n1)Search via IP Address\n2)Search via Domain Name\n3)IO Plot\n4)Summary and Exit"
	echo ""
	echo -n "Enter the choice : "
	read ch1
	echo ""
		case $ch1 in
		1) 
		echo -n "Enter the trace file name : "
		read file1
		echo -e "------------------------------------------------------------------------------------------------------------\n"		
		echo -e "The linked IP addresses are - \n\n"
#awk '{print $3}' $file > TraceToWork2.txt
		awk '{print $3}' $file1 > TraceToWork2.txt
#cat TraceTowork2.txt
		sort -n TraceToWork2.txt > TraceToWork3.txt
		awk "!/[a-z]/" TraceToWork3.txt > TraceToWork4.txt
		uniq TraceToWork4.txt
		echo ""
		echo ""
		echo -n "Enter the IP Address for which you need correspomdimg details : "
		read ip
#grep '^\.$ip\.$' TraceToWork4.txt > TraceToWork5.txt
		awk '$0=="'"$ip"'"' TraceToWork4.txt > TraceToWork5.txt 
		h=`wc -l < TraceToWork5.txt`
			while(($h==0))
			do
			echo "Invalid"
			echo -n "Enter the IP Address for which you need correspomdimg details again : "
			read ip
			awk '$0=="'"$ip"'"' TraceToWork4.txt > TraceToWork5.txt 
			h=`wc -l < TraceToWork5.txt`
			done
		echo ""
		echo -e "The fields available are-\n1)Time\n2)Destination\n3)Protocol\n4)Length\n5)All fields\n\n"
		echo -n "Choice: "
		read ch
			case $ch in
			1) echo -e "Time \t Source IP Address" 
			awk '$3=="'"$ip"'"{print $2 "\t" $3}' $file1
			;;
			2) echo -e "Destination \t Source IP Address"
			awk '$3=="'"$ip"'"{print $4 "\t" $3}' $file1
			;;
			3) echo -e "Protocol \t Source IP Address" 
			awk '$3=="'"$ip"'"{print $5 "\t" $3}' $file1
			;;
			4) echo -e "Length \t Source IP Address"
			awk '$3=="'"$ip"'"{print $6 "\t" $3}' $file1
			;;
			5) echo -e "    S.No  Time\t\tSource IP\t    Destination IP     Protocol    Length    Information  "
			awk '$3=="'"$ip"'"{print $0}' $file1
			;;
			*) echo "Invalid Option "
			esac
			echo -e "------------------------------------------------------------------------------------------------------------\n"
			;;
		2)
		echo -n "Enter the trace filename : "
		read file2
		echo ""
#SENT packages
		awk '$3 ~ /.com/ {print $3}' $file2 > TraceToWork11.txt
		sort -u TraceToWork11.txt > TraceToWork12.txt
		echo  "Queries Generated are - "
		echo ""		
		uniq TraceToWork12.txt
		echo -e "\n"		
		echo -n "Enter the domain name : "
		read dName
		awk '$0=="'"$dName"'"' TraceToWork12.txt > TraceToWork25.txt 
		h1=`wc -l < TraceToWork25.txt`
			while(($h1==0))
			do
			echo "Invalid"
			echo -n "Enter the domain name again - "
			read dName
			awk '$0=="'"$dName"'"' TraceToWork12.txt > TraceToWork25.txt 
			h1=`wc -l < TraceToWork25.txt`
			done
		echo ""
		echo -e "The SENT packets through this link are- \n\n"
		echo -e "    S.No  Time\t\tSource IP\t    Destination IP     Protocol    Length    Information  "		
		awk '$3=="'"$dName"'"{print $0}' $file2 > file3.txt
		cat file3.txt
		echo ""
		echo "The number of packets sent from this link are `wc -l < file3.txt`"
		echo -e "\n\n"
#RECEIVED packages
		echo ""
		awk '$4 ~ /.com/ {print $4}' $file2 > TraceToWork11.txt
		sort -u TraceToWork11.txt > TraceToWork12.txt
		echo -e "------------------------------------------------------------------------------------------------------------\n"
		echo "Responses are - "
		echo ""
		uniq TraceToWork12.txt
		echo ""		
		echo -n "Enter the domain name : "
		read dName
		awk '$0=="'"$dName"'"' TraceToWork12.txt > TraceToWork25.txt 
		h2=`wc -l < TraceToWork25.txt`
			while(($h2==0))
			do
			echo "Invalid"
			echo -n "Enter the IP Address for which you need correspomdimg details again - "
			read dName 
			h2=`wc -l < TraceToWork25.txt`
			done
		echo -e "The RECEIVED packets through this link are- \n\n"

		echo -e "    S.No  Time\t\tSource IP\t    Destination IP     Protocol    Length    Information  "	
		awk '$4=="'"$dName"'"{print $0}' $file2 > file3.txt
		cat file3.txt
		echo "The number of packets received from this link are `wc -l < file3.txt`"

		echo -e "------------------------------------------------------------------------------------------------------------\n"
		#echo "The number of packets received from the link are $h2"		
		;;
		3)echo -e "The Input graph showing the overall traffic of the captured network packets is- \n"
		echo "X-Axis denotes \"Time in Seconds\""
		echo "Y-Axis denotes \"Packets per Second\""
		echo ""
		echo ""
		echo "Blue lines denote the TCP errors"
		echo ""	
		echo -n "Enter the file name with graph : "
		read fileG
		eog $fileG		
		;;
		4) 
		echo ""
		echo -n "Enter the captured filename for summary  : "
		read fileName
		echo -e "\n\n\n--------------------------------------------------------SUMMARY FOR THE CAPTURED 					FILE------------------------------------------------------------\n\n"
		capinfos -A $fileName
		echo -e "\n\n----------------------------------------------------------------THANK YOU!!-------------------------------------------------------------------"
		exit 0
		;;
		*) echo "Invalid Option"
		echo -e "\n\n\n"
		esac
echo -n "Would you like to enter again? (Yes/No) : " 
read choice
if [[ ( "$choice" == "No" ) || ( "$choice" == "no" ) ]]
then
echo "Thank You!!" 
break
fi
done



