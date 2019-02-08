#!/bin/bash
#importing configuration file
source /root/Desktop/netwk_ltcy.conf

#Common Variable
Date=$(date '+%Y%m%d')
DateTimeStamp=$(date '+%y%m%d%H%M')

ERROR="" #Used for error input for options menu

#GREEN='\033[0;34m'
#RED='\033[1;33m'
#NC='\033[0m' # No Color

###############################################################################################################

#scalevalue=10                                                             # decimal points gaana denna one calculation ekata, greater than 10 value ekk denna
#dnscofigfilepath=/etc/sysconfig/################/dns.conf                 # dns config file eka tyna path eka anthimata dnf.conf file name ekath denna
#ttlvariablename="TTL_VALUE"                                               # dns config file eke ttl value kiyana nama tyna widiha
#oldttl=`cat $dnscofigfilepath | grep $ttlvariablename | cut -f 2 -d "="`  # meeka wenas karanna epa
#dnsconfigfilepwd=/etc/sysconfig/#####################                     # dnf conf file path ekata gihin pwd ekk gahala meekata daannaaa


#############################################################################################################################################################




function start(){   


echo     "***************************************************************"
echo     "**  writting ttl value for dns server                        **"
echo     "**  -------------------------------------------------------  **"
echo     " "


#echo "$cat"

	echo " enter the number that which time you are running this script";read category
    	case $category in
		1 )
			ttl_calc ${net_lat[0]}
				;;

		2 ) 
			ttl_calc ${net_lat[1]}
				;;

		3 )
			ttl_calc ${net_lat[2]}
				;;

		4 ) 
			ttl_calc ${net_lat[3]}
				;;
		5 )
			ttl_calc ${net_lat[4]}
				;;

		6 ) 
			ttl_calc ${net_lat[5]}
				;;

		7 )
			ttl_calc ${net_lat[6]}
				;;

		8 ) 
			ttl_calc ${net_lat[7]}
				;;

		9 )
			ttl_calc ${net_lat[8]}
				;;

		10 ) 
			ttl_calc ${net_lat[9]}
				;;

		11 )
			ttl_calc ${net_lat[10]}
				;;

		* ) 
			echo -e "${RED}Invalid Input. Please try again.${NC}"
			sleep 1
			clear



esac 


}





function ttl_calc(){    
network_latency=$1
cpu_load=`top -bn1| grep load | awk '{printf "%.2f\n", $(NF-2)}'`
memory_usage=`top -bn1 | grep Mem | awk '{printf "%.1f\n", $(NF-2)}' | tail -1`
disk_usage=`df -h | head -2 | tail -1 | awk '{print $3}' | cut -b 1,2,3`


#echo "$cpu_load"
#echo "$memory_usage"
#echo "$disk_usage"

kc=0.000005713549545
km=0.2338136617
kd=0.7661806247
kn=0.00194822


c_l=$(bc <<< "scale=$scalevalue ; $kc * $cpu_load")
m_u=$(bc <<< "scale=$scalevalue ; $km * $memory_usage")
d_u=$(bc <<< "scale=$scalevalue ; $kd * $disk_usage")
n_l=$(bc <<< "scale=$scalevalue ; $kn * $network_latency")


#echo "$c_l"
#echo "$m_u"
#echo "$d_u"

p=$(bc <<< "scale=$scalevalue ; $c_l + $m_u + $d_u + $n_l ")

#echo "$p"

pl=$(bc <<< "scale=$scalevalue ; 1 / $p")

#echo "$pl"


ttl=$(bc <<< "scale=$scalevalue ; 1000 * 1 * $pl")

#echo "$ttl"


echo "$ttlvariablename=$ttl"




sed "s/$oldttl/$ttl/g" "$dnscofigfilepath" > $dnsconfigfilepwd/ramal.conf
mv $dnscofigfilepath $dnsconfigfilepwd/yasara.conf
mv $dnsconfigfilepwd/ramal.conf $dnscofigfilepath

echo -e "write TTL VALUE in dns config file : ${GREEN}Successful${NC}";

}

start

