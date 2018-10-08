for solution in ./*problem*.pl ./solution; do
    for driver in ./tests/*driver*.pl; do
        solution=${driver:s/driver/solution:s/pl/txt}
        if [-a solution]; then
            # call to grade solution


            # run prolog with non-interactive mode, ignore warnings.
            # --quiet : quiet mode, no welcome message
            # -t halt : halt after finish (non-interactive)
            # ${solution} script2.pl : run the solution and then script
            # the script prints true if valid solution.
            swipl --quiet -t halt -s ${solution} script2.pl 2>&-
            echo '' # newline
        fi
    done
done