clusterName=$1
region=$2
ips=`aws ec2 describe-network-interfaces --region $region --filters Name=description,Values="Amazon EKS $clusterName" | grep "PrivateIpAddress\"" | cut -d ":" -f 2 |  sed 's/[*",]//g' | sed 's/^\s*//'| uniq`
endpoint=`aws eks describe-cluster --name $clusterName --region $region | grep endpoint\" | cut -d ":" -f 3 | sed 's/[\/,"]//g'`
IFS=$'\n'
# create backup of /etc/hosts
cp /etc/hosts /etc/hosts_backup
sh -c "cat /etc/hosts  | grep -v $endpoint > /etc/hosts_new"

for item in $ips
do
  sh -c "echo $item  $endpoint >> /etc/hosts_new"
done
sh -c "cat /etc/hosts_new > /etc/hosts"
