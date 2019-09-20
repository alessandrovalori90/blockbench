#!/bin/bash
#nnodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

echo "building peer list..."
i=0
for host in `cat $HOSTS`; do
  if [[ $i -lt $1 ]]; then
    echo "admin.addPeer("`ssh $USER@$host $ETH_HOME/enode.sh $host 2>/dev/null | grep enode`")"
    echo "admin.addPeer("`ssh $USER@$host $ETH_HOME/enode.sh $host 2>/dev/null | grep enode`")" >> addPeer.txt
  fi
  let i=$i+1
  echo $i
done
echo "peer list done"

echo "copying peer list to all host..."
for host in `cat $HOSTS`; do
  scp addPeer.txt $USER@$host:$ETH_HOME/addPeer.txt
done
echo "done copying"
