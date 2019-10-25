clusterName=$1
region=$2
ips=$(aws ec2 describe-network-interfaces --region $2 --filters Name=description,Values="Amazon EKS application-staging" | jq -r '.NetworkInterfaces[].PrivateIpAddress')
endpoint=$(aws eks describe-cluster --name $1 --region $2 | jq -r '.cluster.endpoint' | cut -d '/' -f 3)
# create backup of /etc/hosts
cp /etc/hosts /etc/hosts_backup
sh -c "cat /etc/hosts  | grep -v $endpoint > /etc/hosts_new"

for item in $ips
do
  sh -c "echo $item  $endpoint >> /etc/hosts_new"
done
sh -c "cat /etc/hosts_new > /etc/hosts"
