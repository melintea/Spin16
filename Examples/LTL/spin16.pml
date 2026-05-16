/* Leader with large numbers of processes/channels/messages */

short leader = 0; // note the PID type: short
#define N 300       

proctype node(chan in; chan out; short id) {
    short rec;
    out ! id; 
    
    do
    :: in ? rec ->
        if
        :: rec > id -> out ! rec  
        :: rec < id -> skip       
        :: rec == id ->           
            printf("Node %d is leader\n", id);
            leader = leader + 1;
            break
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
ltl p1 /*liveness_election*/ { <> [] (leader == 1) }

