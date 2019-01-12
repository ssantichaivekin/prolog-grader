% accepts predicate for PDAs
% accepts(State, Tape, Stack) is True iff the given PDA
% would accept starting in the given State on the input on the Tape and 
% the given Stack.

% newTape only has 2 rules if first symbol matches first symbol on tape return rest of tape
% second rule if symbol is epsilon, return tape
newTape([Symbol | Rest], Symbol, Rest) :- \+Symbol = epsilon.
newTape(Tape, epsilon, Tape).

% newStack rules
% Pop is first symbol of stack
newStack([Symbol| Rest], Symbol, Push, [Push | Rest]) :- \+Symbol = epsilon, \+Push = epsilon.
newStack([Symbol| Rest], Symbol, epsilon, Rest) :- \+Symbol = epsilon.
newStack(Stack, epsilon, epsilon, Stack).
newStack(Stack, epsilon, Push, [Push| Stack]) :- \+ Push = epsilon.

accepts(Q, [], []) :- accepting(Q).

accepts(Q, Tape, Stack) :-
    ([S | _] = Tape; S = epsilon),
    ([T | _] = Stack; T = epsilon),
    transition(Q, S, T, NewTop, NewQ),
    newTape(Tape, S, NewTape),
    newStack(Stack, T, NewTop, NewStack),
    accepts(NewQ, NewTape, NewStack).


