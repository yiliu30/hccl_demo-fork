CC = g++
MPI_FLAG =

ifeq ($(MPI),1)
    $(info Compiling HCCL demo with MPI)
    CC = mpic++
    MPI_FLAG = -D MPI_ENABLED=1
endif

make:
	$(CC) -std=gnu++0x $(MPI_FLAG) -I/usr/include/habanalabs -I${SPDLOG_ROOT} -Wall \
        -o hccl_demo hccl_demo.cpp affinity.cpp env.cpp send_recv.cpp scale_validation.cpp \
        -D AFFINITY_ENABLED=1 -L/usr/lib/habanalabs/ -lSynapse -lpthread

dev:
	$(CC) -std=gnu++0x $(MPI_FLAG) -I${HCL_ROOT}/include/ -I${SYNAPSE_ROOT}/include/ -I${SPDLOG_ROOT} \
        -g -Wall -o hccl_demo hccl_demo.cpp affinity.cpp env.cpp send_recv.cpp scale_validation.cpp -D AFFINITY_ENABLED=1  \
        -L${BUILD_ROOT_LATEST}/ -lSynapse -lpthread

one_node:
	HCCL_COMM_ID=127.0.0.1:5555 python3 run_hccl_demo.py --nranks 8 --node_id 0 --size 32m --test all_reduce --loop 1000 --ranks_per_node 8

node0:
	HCCL_COMM_ID=<FIRST_NODE_IP>:6006 python3 run_hccl_demo.py --test all_reduce --nranks 16 --loop 1000 --node_id 0 --size 32m --ranks_per_node 8
node1:
	HCCL_COMM_ID=<FIRST_NODE_IP>:6006 python3 run_hccl_demo.py --test all_reduce --nranks 16 --loop 1000 --node_id 1 --size 32m --ranks_per_node 8

kill_demo:
	ps aux | grep hccl_demo | grep -v grep | awk '{print $2}' | xargs kill -9

clean:
	rm -f hccl_demo
