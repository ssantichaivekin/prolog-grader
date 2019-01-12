% accepts predicate for PDAs
% accepts(State, Tape, Stack) is True iff the given PDA
% would accept starting in the given State on the input on the Tape and 
% the given Stack.

accepts(Q, [], []) :- accepting(Q).

accepts(Q, Tape, Stack) :-
    ([S | _] = Tape; S = epsilon),
    ([T | _] = Stack; T = epsilon),
    transition(Q, S, T, NewTop, NewQ),
    newTape(Tape, S, NewTape),
    newStack(Stack, T, NewTop, NewStack),
    accepts(NewQ, NewTape, NewStack).


newTape(Y,epsilon,Y).
newTape([S|Rest],S,Rest):- \+ S = epsilon.

newStack(Y,epsilon, epsilon,Y).
newStack([S|Rest],S, epsilon,Rest) :- \+ S= epsilon.
newStack(Rest,epsilon, S,[S|Rest]):- \+ S= epsilon.
newStack([S|Rest],S, T,[T|Rest]):- \+ S= epsilon, \+ T= epsilon.


