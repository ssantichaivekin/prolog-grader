% The format is
% :- ([### YOUR TEST PREDICATE GOES HERE ###], writeln('true')) ; writeln('false').
%    If the predicate is true, then the script would write 'true' to stdout.
%    If the predicate is false, then the srcipt would write 'false' to stdout.
% In this case, if isAlphabet(g) is true, it will print 'true'
% otherwise, it will print 'false'.
:- (isAlphabet(g), writeln('true')) ; writeln('false').
