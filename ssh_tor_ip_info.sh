# Bash script to search Information and Ip about 
# Tor hidden service of ssh server

# sudo easy_install shodan
# Connect to https://www.shodan.io/, register and get API key
# shodan init API_key

# $1 is the .onion server
rand="/tmp/ssh_finder_$RANDOM"
echo "Creating $rand file"
torify ssh-keyscan $1 2> /dev/null > $rand
ssh-keygen -E md5 -lf $rand

for i in $(ssh-keygen -E md5 -lf $rand | awk '{print $2}' | cut -c 5-); do shodan search --fields ip_str,port,org,hostnames $i; done

rm $rand
echo "Removing $rand"
