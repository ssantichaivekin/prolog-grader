import os
import re
import subprocess

def formatWhiteSpaces(string):
    '''
    Remove the beginning and ending spaces.
    Strip the whitespaces of each line.
    Return the string of lines.
    '''
    string = string.strip()
    lines = []
    for line in string.splitlines() :
        newLine = re.sub(r'\s+', ' ', line.strip())
        lines.append(newLine)
    return lines

def evaluateProlog(prologFiles, timeout=15):
    '''
    Evaluate the concatenation of prolog files.
    Return a string that is the output (stdout) of the
    evaluation.

    Kills the file in timeout time (seconds) if it
    runs for too long.
    '''
    return ''

def gradeCase(prologFiles, driverFile, solutionFile, mode='exact'):
    '''
    See whether the output of the concatenation of the
    files is exactly the same as the solution.

    Modes
    exact = the solution exactly matches the output
    TODO: implement other modes 'in'
    in = there is a solution in the output
    '''
    prologEvaluationFiles = prologFiles + [driverFile]
    output = evaluateProlog(prologEvaluationFiles)
    solutionString = open(solutionFile, 'r').read()
    # remove whitespaces to prevent whitespace mismatch
    # 'true ' should have the same value as 'true', for example.
    shortenedOutput = formatWhiteSpaces(output)
    shortenedSolution = formatWhiteSpaces(solutionString)
    return shortenedOutput == shortenedSolution

def gradeSubmission(prologFiles, testDir, 
                    driverKey='driver', solutionKey='solution'):
    '''
    Grade the prolog files (1 person) against many
    test cases and solutions.
    This will search for driver and solution files
    in the folder test folder.

    The driver/solutionKey is string that every driver
    and solution must have.

    The driver files shoud be in the format
    [driverkey]-[test_name].pl
    and the solutions should be in the format
    [solutionkey]-[test_name].txt

    Write the grading result to stdout.
    '''

def gradeAll(submissionDir='./', submissionKey='problem',
             submissionHelperFiles=[], testDir='tests/'):
    '''
    Run gradeSubmission on all submissions.
    Also append submissionHelperFiles to each
    submission.
    '''
    return None