#!/bin/bash
#nodes
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

rm -rf addPeer.txt
./gather.sh $1
sleep 3
echo start mining...
i=0
for host in `cat $HOSTS`; do
  if [[ $i -lt $1 ]]; then
    ssh -oStrictHostKeyChecking=no $USER@$host $ETH_HOME/start-mining.sh
    echo done node $host
  fi
  let i=$i+1
done
echo adding peers...
i=0
for host in `cat $HOSTS`; do
  if [[ $i -lt $1 ]]; then
    ssh -oStrictHostKeyChecking=no $USER@$host $ETH_HOME/add-peers.sh
    echo done node $host
  fi
  let i=$i+1
done
