% Use this editor as a MiniZinc scratch book
 
int: graph_size;
int: start;
int: n_dest;
array[1..n_dest] of int: dest;
int: n_edges;
array[1..n_edges] of int: from;
array[1..n_edges] of int: to;
array[1..n_edges] of int: cost;
 
% create arcs, blances and flows
% array[1..nbr_arcs, 1..2] of int: arcs = array2d(1..nbr_arcs, 1..2, [if (k mod 2) = 0 then from[i div 2 + 1] else to[i div 2 + 1] | i in 0..2*n_edges -1]
