% Use this editor as a MiniZinc scratch book
include "globals.mzn";
 
int: graph_size;
int: start;
int: n_dests;
array[1..n_dests] of int: dest;
int: n_edges;
array[1..n_edges] of int: from;
array[1..n_edges] of int: to;
array[1..n_edges] of int: cost;
 
% create arcs, blances and flows
array[1..n_edges, 1..2] of int: arcs = array2d(1..n_edges, 1..2, [if (i mod 2) = 0 then from[i div 2 + 1] else to[i div 2 + 1] endif | i in 0..2*n_edges -1]); % kanske 1..

% flatten list
array[1..graph_size] of int: balances = [if i = 1 then n_dests elseif exists (j in 1..n_dests) (dest[j] = i) then -1 else 0 endif | i in 1..graph_size];

array[1..n_edges] of var -1000..1000: flows;

var int: totalCost;


constraint network_flow(arcs, balances, flows);


totalCost = sum([cost[i] | i in 1..n_edges where flows[i] != 0]); %Which ever arch it takes look at the cost for that arc
solve minimize(totalCost);

output["Cost: ", 
show(totalCost)];