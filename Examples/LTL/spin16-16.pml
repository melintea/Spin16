/* Leader with large numbers of processes/channels/messages */
/* gcc -ggdb -DMEMLIM=8192 -DBITSTATE ... */

#define N 300

short leader    = 0; // flag
short leader_id = 0; // note the PID type: short

proctype node(chan in; chan out; short id) {
    short rec;
    out ! id; 
    
end_node: 
    do
    :: in ? rec ->
        if
        :: rec > id -> out ! rec  
        :: rec < id -> skip       
        :: rec == id ->           
            printf("Node %d is leader\n", id);
            atomic { 
                leader = leader + 1; 
                leader_id = id; 
                assert(leader <=1);
            }
            //break
        fi
    od
}

init {
    chan q[N] = [1] of { short }; /* Added channel capacity of 1 to prevent deadlock */
    short i;
    
    atomic {
        i = 0;
        do
        :: i < N-1 ->
            run node(q[i], q[i+1], i);
            i++
        :: i == N-1 ->
            run node(q[i], q[0], i);
            break
        od
    }
}

/* LTL Properties */

/* 1. Safety: Never more than one leader is elected */
ltl p0 /*safety_one_leader*/ { [] (leader <= 1) }

/* 2. Liveness: Eventually, a leader is elected and stays elected */
ltl p1 /*liveness_election*/ { <> [] ((leader == 1) && (leader_id == N-1)) }

