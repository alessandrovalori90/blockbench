ETH_HOME=/home/$USER/blockbench/benchmark/ethereum
HOSTS=$ETH_HOME/hosts
CLIENTS=$ETH_HOME/clients
ETH_DATA=/home/$USER/eth
LOG_DIR=$ETH_HOME/kvstore1
EXE_HOME=/home/$USER/blockbench/src/macro/kvstore
BENCHMARK=ycsb
# private key that should be used to create an account as ethereum coinbase
PRIVATEKEY=$ETH_HOME/UTC--2019-09-16T15-08-01.253440612Z--73c30a6b46203c20b6a7a0d7a9469b5a7d285451

##comment these out for smallbank
#EXE_HOME=$ETH_HOME/../../src/smallbank/ethereum/ycsb
#BENCHMARK=smallbank
