/* Leader with large numbers of processes/channels/messages */
/* gcc -ggdb -DMEMLIM=8192 -DBITSTATE ... */

#define N 300

short elected    = 0;
short leader     = 0; // note the PID type: short

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
                elected = elected + 1; 
                leader = id; 
                assert(elected <=1);
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
ltl p0 /*safety_one_leader*/ { [] (elected <= 1) }

/* 2. Liveness: Eventually, a leader is elected and stays elected */
ltl p1 /*liveness_election*/ { <> [] ((elected == 1) && (elected == N-1)) }

