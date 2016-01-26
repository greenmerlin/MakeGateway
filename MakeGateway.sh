#!/bin/bash
#26/01/2016
#greenmerlin

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



# check if /etc/sysctl.conf exist and ask for a new
if [ ! -f /etc/sysctl.conf ]
then
  echo -e "/etc/sysctl.conf whas not found, should i create for you ?\n"

  if asksure; then
    echo -e "\nOkay, performing echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf..."
    /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
    echo "Okay, performing sysctl -p /etc/sysctl.conf..."
    /bin/su -c "sysctl -p /etc/sysctl.conf"
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

  iptables -t nat -A POSTROUTING --out-interface $Interface2 -j MASQUERADE

echo -e "\nOkay, performing iptables -t nat -A FORWARD --in-interface $Interface1 -j MASQUERADE" 

  iptables -A FORWARD --in-interface $Interface1 -j ACCEPT

