:- (newTape([s, p, a, m], s, [p, a, m]), writeln('true')) ; writeln('false').
:- (newTape([s, p, a, m], p, X), writeln('true')) ; writeln('false').