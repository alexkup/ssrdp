#!/bin/bash
rm discover_rdp.txt
for i in `seq 1 254`; 
do
	ip='192.168.128.'$i
	echo $ip
		nc -z -w 1 $ip 3389 > /dev/null 2>&1
		if [[ $? = 0 ]]; then
			LOOKUP_RES=$(nslookup $ip)
			NAME=$(echo $LOOKUP_RES | sed -n 's/.*arpa.*name = \(.*\)/\1/p');
#awk -F"= " '/name/{print $2}');
	#| grep -v nameserver | cut -f 2 | grep name | cut -f 2 -d "=" | sed 's/ //');
				echo $NAME >> discover_rdp.txt
        		printf "%s%s%s\n" " [$ip:" "UP" "]"
		else
#			printf "%s%s%s\n" " [$ip:" "DOWN" "]"
			echo ""
		fi
done
