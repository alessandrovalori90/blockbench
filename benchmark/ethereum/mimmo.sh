cd `dirname ${BASH_SOURCE-$0}`
. env.sh

if [ "$BENCHMARK" = "smallbank" ]; then
   echo "Strings smallbank..."
   #nohup ./driver -db ethereum -ops 10000 -threads 4 -txrate 10 -fp stat.txt -endpoint 127.0.0.1:8000 
   nohup ./driver -db ethereum -threads 2 -endpoint 192.168.1.10:8000 -txrate 8 -wt 60
else
   echo "Starting YCSB..."
   nohup ./driver -db ethereum -threads $1 -P workloads/workloada.spec -endpoint $host:8000 -txrate $4 -wt 60 > $LOG_DIR/client_$host"_"$1 2>&1 &
fi
