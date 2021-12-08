int: n;                                               % dimension of board
int: n_commercial;                                    % commercial plots to be placed

int: n_residential;                                   % residential plots to be placed
array[1..n+1] of int: point_distribution; % Distribution


int: commercial = 0;   % 1 to represent commercial lot and 
int: residential = 1;  % residential will be 0

% Note that n^2 = n_commercial + n_residential
% will need a matrix, of dimension nxn, to represent the different placcements of
% commercial and residential lots

include "globals.mzn";

array[1..n, 1..n] of var 0..1: matrix;

array[1..n] of var int: res_rows;
array[1..n] of var int: res_cols;

% need a constraint to ensure that the count of '0' in row i matches
% the ith index in res_rows and vice versa with res_cols

constraint lex2(matrix);

constraint forall(i in 1..n) (
            let {
              var bool: a = count(row(matrix, i), residential, res_rows[i]); 
              var bool: b = count(col(matrix, i), residential, res_cols[i]);
                } in a \/ b
);

array[int] of var int: row_points = [point_distribution[res_rows[i]] | i in 1..n];
array[int] of var int: col_points = [point_distribution[res_cols[i]] | i in 1..n];

var int: num_res = sum(res_rows);
constraint num_res = n_residential;

var int: sum_row = sum(row_points);
var int: sum_col = sum(col_points);
var int: total_cost;

constraint total_cost = sum_row + sum_col;

solve maximize total_cost;


output["point distribution := ", show(point_distribution), 
       "matrix := ", show(matrix), 
       " and total cost ", show(total_cost)];


