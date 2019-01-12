:- (accepts(q0, []),                       writeln('true')); writeln('false'). % true
:- (accepts(q0, [0]),                      writeln('true')); writeln('false'). % true
:- (accepts(q0, [1]),                      writeln('true')); writeln('false'). % true
:- (accepts(q0, [0, 1]),                   writeln('true')); writeln('false'). % false
:- (accepts(q0, [1, 0]),                   writeln('true')); writeln('false'). % false
:- (accepts(q0, [0, 0, 0, 0, 0]),          writeln('true')); writeln('false'). % true
:- (accepts(q0, [1, 1, 1, 1, 1]),          writeln('true')); writeln('false'). % true
:- (accepts(q0, [0, 0, 1, 1, 0, 1, 0]),    writeln('true')); writeln('false'). % true
:- (accepts(q0, [1, 1, 0, 0, 1, 0, 1]),    writeln('true')); writeln('false'). % true
:- (accepts(q0, [0, 0, 0, 1, 0, 1, 1]),    writeln('true')); writeln('false'). % false
:- (accepts(q0, [1, 1, 1, 0, 1, 0, 0]),    writeln('true')); writeln('false'). % false
:- (accepts(q0, [0, 0, 0, 0, 0, 1, 1, 1]), writeln('true')); writeln('false'). % false
:- (accepts(q0, [1, 1, 1, 1, 1, 0, 0, 0]), writeln('true')); writeln('false'). % false
