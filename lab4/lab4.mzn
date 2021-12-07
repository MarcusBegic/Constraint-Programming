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

constraint forall (node in 1..n)(
    forall(neighbour in dependencies[node])(
      start_time[node] + duration[node] <= start_time[neighbour] 
      ));


constraint
	forall(mul_val in mul)(
			duration[mul_val] = del_mul
	);

constraint
	forall(add_val in add)(
			duration[add_val] = del_add
    );


%output [show(add)];
