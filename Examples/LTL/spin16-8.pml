/* Leader */

#define N 10

byte elected    = 0;
byte leader     = 0;

proctype node(chan in; chan out; byte id) {
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
    chan q[N] = [1] of { byte }; /* Added channel capacity of 1 to prevent deadlock */
    byte i;
    
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
ltl p1 /*liveness_election*/ { <> [] ((elected == 1) && (leader == N-1)) }

