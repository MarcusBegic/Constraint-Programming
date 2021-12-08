include "globals.mzn";

int: del_add; 
int: del_mul; % delay/clock cycles

int: number_add;
int: number_mul;

int: n;

set of int: last;
set of int: add;
set of int: mul;

array[1..n] of set of int: dependencies; 

array[1..n] of var 0..100: start_time;
array[1..n] of var 1..2: duration;

int : d_max = max(del_mul, del_add);
int : r_max = max(number_mul, number_add);

array[1..n] of var 0..n*d_max : t;
array[1..n] of var 0..d_max : d;
array[1..n] of var 1..r_max : r;
var int : score;

constraint forall (adder in add)(
    forall(neighbour in dependencies[adder])(
      t[adder] + del_add <= t[neighbour] 
    ));

constraint forall (muller in mul)(
    forall(neighbour in dependencies[muller])(
      t[muller] + del_mul <= t[neighbour] 
    ));

constraint
	forall(mul_val in mul)(
			d[mul_val] = del_mul
    );

constraint
	forall(add_val in add)(
			d[add_val] = del_add
    );


constraint diffn([t[i] | i in add], [r[i] | i in add], [del_add | i in add], [1 | i in add]);
constraint diffn([t[i] | i in mul], [r[i] | i in mul], [del_mul | i in mul], [1 | i in mul]);
%resource sharing constraints


constraint cumulative([t[i] | i in add],[del_add | i in add], [1 | i in add], number_add);
constraint cumulative([t[i] | i in mul],[del_mul | i in mul], [1 | i in mul], number_mul);
%solver constraints

%constraint forall(i in 1..n)(
%diff2());

constraint forall(i in last)(t[i] + d[i] <= score);


%cumulative(array[int] of var int: s, array[int] of var int: d, array[int] of var int: r, var int: b)
%It requires that a set of tasks given by start times s, durations d, and resource requirements r, never require more than a global resource bound b at any one time.

%om man får number limitiation begränsa ints står i handledningen

 
solve :: int_search(t, first_fail, indomain_min, complete)
         minimize score;

output[show(score)];

/* array[1..number_add] of var 0..100: add_start; */
/* constraint */
/* 	add_start = [start_time[i] | i in 1..n where i in add]; */
	
	
/* array[1..number_mul] of var 0..100: mul_start; */
/* constraint */
/* 	mul_start = [start_time[i] | i in 1..n where i in mul]; */




/* array[1..number_add] of int: deltaS_add; */
/* array[1..number_add] of int: deltaNode_add; */
/* deltaS_add = [del_add | i in 1..number_add]; */
/* deltaNode_add = [del_add | i in 1..number_add]; */

/* array[1..n] of var 1..number_add: nodeBoi_add; */

/* constraint diffn(start_time, nodeBoi_add, deltaS_add, deltaNode_add); */

/* array[1..number_mul] of int: deltaS_mul; */
/* array[1..number_mul] of int: deltaNode_mul; */
/* deltaS_mul = [del_add | i in 1..number_mul]; */
/* deltaNode_mul = [del_add | i in 1..number_mul]; */

/* array[1..n] of var 1..number_add: nodeBoi_mul; */

/* constraint diffn(start_time, nodeBoi_mul, deltaS_mul, deltaNode_mul); */





