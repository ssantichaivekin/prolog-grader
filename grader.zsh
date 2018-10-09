# Requirement checks
# check for timeout or gtimeout and swipl
requirementCheck() {
    timeoutcmd=''
    requirementsSatisfied='true'
    if type timeout >&- ; then
        timeoutcmd='timeout'
    elif type gtimeout >&- ; then
        timeoutcmd='gtimeout'
    else
        echo 'Timeout command is not installed.'
        echo 'This script requires timeout to make sure Prolog does not' \
            'run into an infinite loop.'
        echo 'If you are using mac with homebrew installed, install with:'
        echo '    brew install coreutils'
        requirementsSatisfied='false'
    fi

    if ! type swipl >&- ; then
        echo 'Needs swipl to run prolog.'
        echo 'If you are using mac with homebrew installed, install with:'
        echo '    brew install swi-prolog'
        requirementsSatisfied='false'
    fi

    result=[[ requirementsSatisfied == 'true']]
    return result
}

# If requirements are not satisfied, exit.
if ! requirementCheck ; do
    exit 1
fi

# define a function that runs prolog files
# use 15s max for any run.
runprolog () {
    ${timeoutcmd} 15s swipl --quiet -t halt -s
}


# for each problem submission in the current directory
for submission in ./*problem*.pl ; do
    # create a folder to store that person's result
    submissionFolder=${submission:s/driver/}
    # for each pair of test case driver/solution file in test directory
    for testDriver in ./tests/*driver*.pl ; do
        # find the test solution (expected output) by changing the word 
        # driver to solution. the solution should be a text file.
        testSolution=${testDriver:s/driver/solution:s/pl/txt}
        # set the counters to 0
        (( countCorrectTest = 0 ))
        (( countTotalTest = 0 ))
        # if the solution does not exist for that test, skip
        if [[ -a testSolution ]] ; then
            # call to grade solution

            # run prolog with non-interactive mode, ignore warnings.
            # --quiet : quiet mode, no welcome message
            # -t halt : halt after finish (non-interactive)
            # ${solution} script2.pl : run the solution and then script
            # the script prints true if valid solution.
            swipl --quiet -t halt -s ${solution} script2.pl 2>&-
            echo '' # newlin
        else
            echo "${testDriver} has no matching solution"
            echo "Expected file: ${testSolution}"
        fi
    done
done