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
array[1..n_edges, 1..2] of int: arcs = array2d(1..n_edges, 1..2, [if (i mod 2) = 0 then from[i div 2 + 1] else to[i div 2 + 1] endif | i in 0..2*n_edges -1]); % kanske 1..

array[1..graph_size] of int: balances = [if i = 1 then n_dest elseif exists (j in 1..n_dest) (dest[j] = i) then -1 else 0 endif | i in 1..graph_size];


