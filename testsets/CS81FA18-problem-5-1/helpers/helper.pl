accepts(Q, []) :- accepting(Q).
accepts(Q, [Symbol | Rest]) :- transition(Q, Symbol, NewQ), accepts(NewQ, Rest).