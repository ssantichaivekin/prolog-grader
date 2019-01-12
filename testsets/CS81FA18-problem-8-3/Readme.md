construct a PDA for the language of all binary strings in which the 0’s and 1’s are in no particular order but the total number of 0’s is exactly twice the total number of 1’s. Place your Prolog implementation of the PDA in a file called problem3.pl. Please name your start state q0. Here’s what it should look like:

?- [accepts].
true
?- [problem3].
true
?- accepts(q0, [0, 0, 0, 0, 1, 1], []).
true
?- accepts(q0, [1, 0, 1, 0, 0, 0], []).
true
?- accepts(q0, [1, 0, 0, 1, 0], []).
false