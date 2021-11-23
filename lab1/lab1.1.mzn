include "globals.mzn";
% Use this editor as a MiniZinc scratch book

int: n; % number of people
int: n_prefs; % number of preferences

array[1..n_prefs, 1..2] of int: prefs; % preferences, 2D matrix
                                       % each element represents a preference between two individuals

array[1..n] of var 1..n: pos;
array[1..n_prefs] of var int: d; % distance to all preferences, this is the matrix we wish to maximize

%constraints
constraint alldifferent(pos); % ensure uniqueness
constraint pos[1] < pos[2]; % total ordering
constraint forall (i in 1..n_prefs) (
    let {
        var int : x = pos[prefs[i,1]] - pos[prefs[i,2]] 
        } 
    in d[i] = abs(x) % cost function
);


solve maximize among(d, {1}); % maximize number of matches where a preference is seated next to heir preference

var int: res = among(d, {1});


output["RESULT :", show(res)]

