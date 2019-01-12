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


newTape([X | NewTape], X, NewTape).
newTape(Tape, Symbol, Tape) :- Symbol = epsilon.

newStack([Pop | Rest], Pop, Push, [Push | Rest]) :- \+ Push = epsilon.
newStack([Pop | Rest], Pop, Push, Rest) :- Push = epsilon.
newStack(Stack, Pop, Push, [Push | Stack]) :- Pop = epsilon, \+ Push = epsilon.
newStack(Stack, Pop, Push, Stack) :- Pop = epsilon, Push = epsilon.