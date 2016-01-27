#!/bin/bash
#26/01/2016
#greenmerlin
#Mon copain Peko m'aide !!

readonly PATH=/etc/sysctl.conf


asksure() {
echo -n "(Y/N)? "
while read -r -n 1 -s answer; do
  if [[ $answer = [YyNn] ]]; then
    [[ $answer = [Yy] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
  fi
done

return $retval
}



# check if $PATH exist and ask for a new
if [ ! -f $PATH ]
then
  echo -e $PATH whas not found, should i create for you ?

  if asksure; then
    echo -e "\nOkay, performing echo 'net.ipv4.ip_forward = 1' >> $PATH..."
    /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> $PATH"
    echo "Okay, performing sysctl -p $PATH..."
    /bin/su -c "sysctl -p $PATH"
else
  echo "Pfff..."
  exit 0
fi
fi

echo -e "###########################"
echo -e "##SELECTION DES INTERFACE##\n"
read -p "First Interface(from) : " Interface1
read -p "Second Interface(to) : " Interface2

echo -e "\nOkay, performing iptables -t nat -A POSTROUTING --out-interface $Interfacer2 -j MASQUERADE"

  /sbin/iptables -t nat -A POSTROUTING --out-interface $Interface2 -j MASQUERADE

echo -e "\nOkay, performing iptables -t nat -A FORWARD --in-interface $Interface1 -j MASQUERADE" 

  /sbin/iptables -A FORWARD --in-interface $Interface1 -j ACCEPT

