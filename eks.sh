clusterName=$1
ips=`aws ec2  describe-network-interfaces --filters Name=description,Values="Amazon EKS $clusterName" | grep "PrivateIpAddress\"" | cut -d ":" -f 2 |  sed 's/[*",]//g' | sed 's/^\s*//'| uniq`
endpoint=`aws eks describe-cluster --name $clusterName | grep endpoint\" | cut -d ":" -f 3 | sed 's/[\/,"]//g'`
IFS=$'\n'
# create backup of /etc/hosts
cp /etc/hosts /etc/hosts_backup
sh -c "cat /etc/hosts  | grep -v $endpoint &gt; /etc/hosts_new"

for item in $ips
do
  sh -c "echo $item  $endpoint &gt;&gt; /etc/hosts_new"
done
sh -c "cat /etc/hosts_new &gt; /etc/hosts"
