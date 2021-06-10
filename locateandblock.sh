#! /bin/bash
#Coded by Justin 
echo "enter number of ip:"
read n
echo "enter $n  IPs"
for (( i=1;  i <= n; i++ ))
do
  read IP[$i] 
done
>remove.txt
for (( i=1;  i <= n; i++ ))
do
  opps=`echo ${IP[$i]} | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"`
  m=$(curl -s  https://ipinfo.io/$opps | jq -r '.country')
  k=$(curl  -s https://restcountries.eu/rest/v2/alpha/$m | jq -r '.name')
  echo  "$opps - $k"
  VAR1="United States of America"
  VAR2="$k"
  if [ "$VAR1" != "$VAR2" ]; then
   echo "$opps" >>remove.txt
  fi
done
counter=0
while read line; do
  out_array[$counter]=$line;
  let counter=counter+1;
done < remove.txt
 echo "To block this ip use below command"
 echo "csf -d ${out_array[@]}" '"ddos"'
