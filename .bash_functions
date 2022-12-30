# Insert your API Keys below.
IPINFO_KEY=""
SHODAN_KEY=""
CENSYS_API=""
CENSYS_KEY=""
STALKPHISH_KEY=""
ECHOTRAIL_KEY=""
PHISHTANK_KEY=""
OTX_KEY=""
GREYNOISE_KEY=""
RISKIQ_KEY=""
RISKIQ_SECRET=""

function myip {
        if [ -z $1 ]; then
                url="https://ipinfo.io/"
                curl -s -X GET "$url" | jq -r '.ip'
        elif [ "$1" = "-v" ]; then
                url="https://ipinfo.io/"
                curl -s -X GET "$url" | jq '.'
        fi

}

function ipinfo {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : ipinfo <ip>"
                echo 'example : ipinfo "1.1.1.1"'
        else
                url="https://ipinfo.io/$1"
                curl -s -X GET "$url" \
                        -H "Accept: application/json" \
                        -H "Authorization: Bearer $IPINFO_KEY" | jq '.'
        fi
}

function greynoise {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : greynoise <ip>"
                echo 'example : greynoise "1.1.1.1"'
        else
                url="https://api.greynoise.io/v3/community/$1"
                curl -s -X GET "$url" \
                     -H "Accept: application/json" \
                     -H "key: $GREYNOISE_KEY" | jq '.'
        fi
}

function shodan {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : shodan <type> <value>"
                echo ""
                echo "------- : ----------------------"
                echo "type    : value"
                echo "------- : ----------------------"
                echo "ip      : Public IPv4 Address"
                echo "resolve : Domain(s)"
                echo "reverse : Public IPv4 Address(s)"
                echo "------- : ----------------------"
                echo ""
                echo 'example : shodan ip "1.1.1.1"'
                echo 'example : shodan resolve "google.com,facebook.com"'
                echo 'example : shodan reverse "8.8.8.8,1.1.1.1"'
        elif [ "$1" = "ip" ]; then
                url="https://api.shodan.io/shodan/host/$2?key=$SHODAN_KEY"
                curl -s -X GET "$url" | jq '.'
        elif [ "$1" = "resolve" ]; then
                url="https://api.shodan.io/dns/resolve?hostnames=$2&key=$SHODAN_KEY"
                curl -s -X GET "$url" | jq '.'
        elif [ "$1" = "reverse" ]; then
                url="https://api.shodan.io/dns/reverse?ips=$2&key=$SHODAN_KEY"
                curl -s -X GET "$url" | jq '.'
        fi
}

function censys {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : censys <ip>"
                echo 'example : censys "1.1.1.1"'
        else
                url="https://search.censys.io/api/v2/hosts/$1"
                curl -s -X GET "$url" \
                     -u $CENSYS_API:$CENSYS_KEY | jq '.'
        fi
}

function stalkphish {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : stalkphish <type> <value>"
                echo ""
                echo "------- : -------------------"
                echo "type    : value"
                echo "------- : -------------------"
                echo "ipv4    : Public IPv4 Address"
                echo "url     : Web URL"
                echo "------- : -------------------"
                echo ""
                echo 'example : stalkphish ipv4 "1.1.1.1"'
                echo 'example : stalkphish url "https://google.com/api"'
        else
                url="https://api.stalkphish.io/api/v1/search/$1/$2"
                curl -s -X GET "$url" \
                     -H "authorization:Token $STALKPHISH_KEY" | jq '.'
        fi
}

function echotrail {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : echotrail <process_name>"
                echo 'example : echotrail "svchost.exe"'
        else
                url="https://api.echotrail.io/v1/private/insights/$1"
                curl -s -X GET "$url" \
                     -H "X-Api-key:$ECHOTRAIL_KEY" | jq '.'
        fi
}

function phishtank {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : phishtank <url>"
                echo 'example : phishtank "https://example.com"'
        else
                url="https://checkurl.phishtank.com/checkurl/"
                phish_url=$(echo -n "$1" | base64 -w0)
                curl -s -X POST "$url" \
                     -A "phishtank/isuru" \
                     -d "url=$phish_url" \
                     -d "format=json" \
                     -d "app_key=$PHISHTANK_KEY" | jq '.'
        fi
}

function otx {
        if [ -z $1 ]; then
                echo ""
                echo "usage            : otx <type> <query> <value>"
                echo ""
                echo "---------------- : --------------------------------------------------------------------"
                echo "type             : query"
                echo "---------------- : --------------------------------------------------------------------"
                echo "IPv4             : general, reputation, geo, malware, url_list, passive_dns, http_scans"
                echo "IPv6             : general, reputation, geo, malware, url_list, passive_dns"
                echo "domain           : general, geo, malware, url_list, passive_dns, whois, http_scans"
                echo "hostname         : general, geo, malware, url_list, passive_dns, http_scans"
                echo "file             : general, analysis"
                echo "url              : general, url_list"
                echo "cve              : general"
                echo "nids             : general"
                echo "correlation-rule : general"
                echo "---------------- : --------------------------------------------------------------------"
                echo ""
                echo 'example          : otx IPv4 reputation "1.1.1.1"'
                echo 'example          : otx IPv6 malware "2a03:2880:10:1f02:face:b00c::25"'
                echo 'example          : otx domain whois "google.com"'
                echo 'example          : otx hostname general "otx.alienvault.com"'
                echo 'example          : otx file analysis "6c5360d41bd2b14b1565f5b18e5c203cf512e493"'
                echo 'example          : otx url url_list "http://www.example.com/sport/4x4_san_ponso/slides/IMG_0068.html"'
                echo 'example          : otx cve general "CVE-2014-0160"'
                echo 'example          : otx nids general "2820184"'
                echo 'example          : otx correlation-rule general "572f8c3c540c6f0161677877"'
        else
                url="https://otx.alienvault.com/api/v1/indicators/$1/$3/$2"
                curl -s -X GET "$url" \
                     -H "X-OTX-API-KEY:$OTX_KEY" | jq '.'
        fi
}

function threatminer {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : threatminer <type> <query> <value>"
                echo ""
                echo "------- : ----- : ---------------------------"
                echo "type    : query : description"
                echo "------- : ----- : ---------------------------"
                echo "domain  : 1     : WHOIS"
                echo "domain  : 2     : Passive DNS"
                echo "domain  : 3     : URIs"
                echo "domain  : 4     : Related Samples (hash only)"
                echo "domain  : 5     : Subdomains"
                echo "domain  : 6     : Report tagging"
                echo "------- : ----- : ---------------------------"
                echo "ip      : 1     : WHOIS"
                echo "ip      : 2     : Passive DNS"
                echo "ip      : 3     : URIs"
                echo "ip      : 4     : Related Samples (hash only)"
                echo "ip      : 5     : SSL Certificates (hash only)"
                echo "ip      : 6     : Report tagging"
                echo "------- : ----- : ---------------------------"
                echo ""
                echo 'example : threatminer domain 3 "google.com"'
                echo 'example : threatminer ip 4 "1.1.1.1"'
        elif [ "$1" = "domain" ]; then
                url="https://api.threatminer.org/v2/domain.php?q=$3&rt=$2"
                curl -s -X GET "$url" | jq '.'
        elif [ "$1" = "ip" ]; then
                url="https://api.threatminer.org/v2/host.php?q=$3&rt=$2"
                curl -s -X GET "$url" | jq '.'
        fi
}

function riskiq {
        if [ -z $1 ]; then
                echo ""
                echo "usage   : riskiq <type> <query> <value>"
                echo ""
                echo "---------- : ------- : ----------------------------------"
                echo "type       : query   : description"
                echo "---------- : ------- : ----------------------------------"
                echo "passivedns : N/A     : All Passive DNS Results"
                echo "passivedns : unique  : Unique Passive DNS Results"
                echo "passivedns : keyword : Search Passive DNS using a keyword"
                echo "------- : ----- : ---------------------------------------"
                echo ""
                echo 'example : riskiq passivedns "google.com"'
                echo 'example : riskiq passivedns unique "google.com"'
                echo 'example : riskiq passivedns keyword "google"'
        elif [ "$1" = "passivedns" ]; then
                ENCODED_API_KEY=$(echo -n "$RISKIQ_KEY:$RISKIQ_SECRET" | base64 -w0)
                url="https://api.riskiq.net/pt/v2/dns/passive?query=$2"
                curl -s -X GET "$url" \
                     -H "Authorization: Basic $ENCODED_API_KEY" | jq '.'
        elif [ "$1" = "passivedns" ] && [ "$2" = "unique" ]; then
                ENCODED_API_KEY=$(echo -n "$RISKIQ_KEY:$RISKIQ_SECRET" | base64 -w0)
                url="https://api.riskiq.net/pt/v2/dns/passive/unique?query=$3"
                curl -s -X GET "$url" \
                     -H "Authorization: Basic $ENCODED_API_KEY" | jq '.'
        elif [ "$1" = "passivedns" ] && [ "$2" = "keyword" ]; then
                ENCODED_API_KEY=$(echo -n "$RISKIQ_KEY:$RISKIQ_SECRET" | base64 -w0)
                url="https://api.riskiq.net/pt/v2/dns/search/keyword?query==$3"
                curl -s -X GET "$url" \
                     -H "Accept: application/json" \
                     -H "Authorization: Basic $ENCODED_API_KEY" | jq '.' 
        fi
}

function colormap {
        for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

function tcpscan {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <host> <port, ports, or port-range>"
    return
  fi

  local host=$1
  local ports=()
  case $2 in
    *-*)
      IFS=- read start end <<< "$2"
      for ((port=start; port <= end; port++)); do
        ports+=($port)
      done
      ;;
    *,*)
      IFS=, read -ra ports <<< "$2"
      ;;
    *)
      ports+=($2)
      ;;
  esac

  for port in "${ports[@]}"; do
   /usr/bin/timeout 1 /bin/bash -c "2>/dev/null echo > /dev/tcp/$host/$port" &&
      echo "port $port is open" ||
      echo "port $port is closed"
  done
}

function udpscan {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <host> <port, ports, or port-range>"
    return
  fi

  local host=$1
  local ports=()
  case $2 in
    *-*)
      IFS=- read start end <<< "$2"
      for ((port=start; port <= end; port++)); do
        ports+=($port)
      done
      ;;
    *,*)
      IFS=, read -ra ports <<< "$2"
      ;;
    *)
      ports+=($2)
      ;;
  esac

  for port in "${ports[@]}"; do
   /usr/bin/timeout 1 /bin/bash -c "2>/dev/null echo > /dev/udp/$host/$port" &&
      echo "port $port is open" ||
      echo "port $port is closed"
  done
}
