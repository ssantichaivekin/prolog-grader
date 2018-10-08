swipl --quiet -t halt -s script3.pl 2>&-
for solution in ./30*problem*.pl ./solution; do
    echo ${solution}
    # run prolog with non-interactive mode, ignore warnings.
    # --quiet : quiet mode, no welcome message
    # -t halt : halt after finish (non-interactive)
    # ${solution} script2.pl : run the solution and then script
    # the script prints true if valid solution.
    swipl --quiet -t halt -s ${solution} script2.pl 2>&-
    echo '' # newline
done