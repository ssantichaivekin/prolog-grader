# Requirement checks
# check for timeout or gtimeout and swipl
check-requirement() {
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

    result=[[ requirementsSatisfied == 'true' ]]
    return result
}

# checks that all drivers have matching solution.
check-driver-solution () {
    gradingDir=${1:-'./'}
    requirementsSatisfied='true'
    for testDriver in ${gradingDir}/tests/*driver*.pl ; do
        # find the test solution (expected output) by changing the word 
        # driver to solution. the solution should be a text file.
        testSolution=${testDriver:s/driver/solution:s/pl/txt}
        # if the solution does not exist for that test, skip
        if [[ ! -a testSolution ]] ; then
            echo "${testDriver} has no matching solution"
            echo "Expected file: ${testSolution}"
            requirementsSatisfied='false'
        fi
    done

    result=[[ requirementsSatisfied == 'true' ]]
    return result
}

# If requirements are not satisfied, exit.
if ! check-requirement ; do
    exit 1
fi
# If requirements are not satisfied, exit.
if ! check-driver-solution ; do
    exit 1
fi

# define a function that runs prolog files
# use 15s max for any run.
# runs a concatenation of all arguments.
run-prolog () {
    # run prolog with non-interactive mode, ignore warnings.
    # --quiet : quiet mode, no welcome message
    # -t halt : halt after finish (non-interactive)
    ${timeoutcmd} 15s swipl --quiet -t halt -s $@
}

# return true of two texts are similar
# use awk.
similar-text () {
    # use awk to format both text files

    # use diff to see whether they are equal
}

run-and-grade-all () {
    # recieve the directory as grading, the default is ./
    gradingDir=${1:-'./'}
    # get all the helper files
    helperFiles=( ${gradingDir}/*helper*.pl(N) )
    # for each problem submission in the current directory
    for submission in ${gradingDir}/*problem*.pl ; do
        # create a folder to store that person's result
        submissionFolder=${submission:s/driver/}
        echo '#####' 'Grading submission:' ${submission:s/driver/} '#####'
        # set the counters to 0
        (( countCorrectTest = 0 ))
        (( countTotalTest = 0 ))
        # for each pair of test case driver/solution file in test directory
        for testDriver in ${gradingDir}/tests/*driver*.pl ; do
            # find the test solution (expected output) by changing the word 
            # driver to solution. the solution should be a text file.
            testSolution=${testDriver:s/driver/solution:s/pl/txt}
            outDest=${testDriver:s/driver/output:s/pl/txt}
            errDest=${testDriver:s/driver/errors:s/pl/txt}
            run-prolog ${helperFiles} ${submission} ${testDriver} \
                            1> ${submissionFolder}/${outDest} \
                            2> ${submissionFolder}/${errDest}
            # if the submission output is the same as the expected
            # output, we add the score, if not, just add the total
            if similar-text ${outDest} ${errDest} ; then
                (( countCorrectTest += 1))
                (( countTotalTest += 1))
            else
                (( countTotalTest += 1))
            fi
        done
        echo 'CorrectTests:' ${countCorrectTest} '/' ${countTotalTest}
    done
}


