cd `dirname ${BASH_SOURCE-$0}`
. env.sh
for com in `cat $ETH_HOME/addPeer.txt`; do
  geth --exec $com attach ipc:/$ETH_DATA/geth.ipc
done
