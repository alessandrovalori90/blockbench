# BlockBench

BlockBench is the first benchmarking framework for private blockchain systems.
It serves as a fair means of comparison for different platforms and enables deeper understanding
of different system design choices.

BlockBench comes with both [macro benchmark workloads](src/macro) for evaluating the overall performance and
[micro benchmark workloads](src/micro) for evaluating performance of individual layers. 

## Workloads 

### Macro-benchmark

* YCSB (KVStore).
* SmallBank (OLTP).

### Micro-benchmark

* DoNothing (consensus layer).
* IOHeavy (data model layer, read/write oriented).
* Analytics (data model layer, analytical query oriented).
* CPUHeavy (execution layer).

## Source file structure

+ Smart contract sources are in [benchmark/contracts](benchmark/contracts) directory.
+ Instructions and scripts to run benchmarks for Ethereum, Hyperledger , Parity and Quorum are in [ethereum](benchmark/ethereum),
[hyperledger](benchmark/hyperledger) , [parity](benchmark/parity) , [quorum_raft](benchmark/quorum_raft) and [quorum_vote](benchmark/quorum_vote) directories respectively.
+ Drivers for benchmark workloads are in [src](src) directory.

## Dependency

### C++ libraries
* [restclient-cpp](https://github.com/mrtazz/restclient-cpp)

  Note: we patched this library to include the "Expect: " header in POST requests, which considerably improves the speed for
  processing RPC request at Parity. 

    + The patch file is include in [benchmark/parity](benchmark/parity) folder.
    + To patch: go to top-level directory of restclient-cpp, then:

        `patch -p4 < $BLOCK_BENCH_HOME/benchmark/parity/patch_restclient`

    + The installation can then proceed as normal. 

* [libcurl](https://curl.haxx.se/libcurl/)

### Node.js libraries
Go to [micro](src/micro) directory and use `npm install` to install the dependency libraries
* [Web3.js](https://github.com/ethereum/web3.js/)
* [zipfian](https://www.npmjs.com/package/zipfian)
* [bignumber.js](https://www.npmjs.com/package/bignumber.js)

### Blockchain 
* [geth(ethereum)](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Ubuntu)
* [geth(parity)](https://github.com/paritytech/parity/wiki/Setup)
* [geth(quorum)](https://github.com/jpmorganchase/quorum/wiki/Getting-Set-Up)
* [hyperledger](https://github.com/hyperledger/fabric/tree/v0.6)

## Install
* dependencies for restclient-cpp:
	+ sudo apt-get install build-essential
	+ sudo apt-get install libtool
	+ sudo apt-get install autoconf
	+ sudo apt-get install libcurl4-gnutls-dev
* restclient-cpp needed to compile the client:
	+ git clone https://github.com/mrtazz/restclient-cpp.git
	+ cd restclient-cpp/ && ./autogen.sh && ./configure && sudo make install
* blockbench:
	+ git clone https://github.com/alessandrovalori90/blockbench
	+ cd blockbench/src/macro/kvstore/
	+ make
* ssh for linux scripts:
	+ sudo apt-get install openssh-server (allows ssh clients to connect to you)
	+ ssh-keygen -b 4096 (Note: leave the password blank. This command will create a public and private key inside the hidden folder /home/your_username/.ssh)
	+ copy the public key and rename the copy as: "authorized_keys"

## Differences with original repository
* added --allow-insecure-unlock option for geth unlock account
* modified genesis blocks for ethereum
* modified Json-RPC calls in the client
* using fixed account for ethereum for testing
* Note: use at least 2 cores and 4Gb of ram or the -wt of the client needs to be greatly increased.


