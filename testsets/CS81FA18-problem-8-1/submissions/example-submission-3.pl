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

newTape(Tape, epsilon, Tape).
newTape([Symbol | NewTape], Symbol, NewTape).

newStack([Pop | Stack], Pop, Push, [Push | Stack]) :- \+ Push=epsilon.
newStack(Stack, epsilon, Push, [Push | Stack]) :- \+ Push=epsilon.
newStack([Pop | Stack], Pop, epsilon, Stack).
newStack(Stack, epsilon, epsilon, Stack).
