Construct your own PDA for the language L = {0^{2i}1^{i} | i ≥ 0} in Prolog in a file called problem2.pl. (Ideally, you should test your code with the accepts predicate from Problem 1, but you can also encode the PDA in this file without using the results from Problem 1 to test it.) Please name your start state q0. Here’s what it should look like:

?- [accepts].
true
?- [problem2].
true
?- accepts(q0, [0, 0, 0, 0, 1, 1], []).
true
?- accepts(q0, [0, 0, 0, 0, 0, 1, 1, 1], []).
false