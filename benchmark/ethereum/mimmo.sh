#!/bin/bash
#arg num_nodes #num_threads num_clients tx_rate [-drop]
cd `dirname ${BASH_SOURCE-$0}`
. env.sh

./stop-all.sh $1 

./init-all.sh $1 
./start-all.sh $1 
