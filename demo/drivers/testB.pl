% The format is
% :- ([### YOUR TEST PREDICATE GOES HERE ###], writeln('true')) ; writeln('false').
%    If the predicate is true, then the script would write 'true' to stdout.
%    If the predicate is false, then the srcipt would write 'false' to stdout.
% In this case, if isAlphabet(b) is true, it will print 'true'
% otherwise, it will print 'false'.
:- (isAlphabet(b), writeln('true')) ; writeln('false').
