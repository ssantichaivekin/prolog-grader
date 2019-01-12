A zsh prolog grader designed to grade HMC CS81 prolog assignments downloaded from
canvas.

## How do I download the student assignments?

On the *Grades* section of the page, if you hover over the problem name, a dropdown menu will appear.
Click *Download Submissions*.

![Download Submissions](download-submissions.png)

## Introduction

This is a python script that uses swi-prolog executable to run multiple prolog files. The idea is that
we can make the prolog console write something to stdout by using the `writeln` predicate. Every time
writeln evaluates, it will print its argument. We then write a script to compare the output of swi-prolog
with the expected output we already have.
For example, one can write a test case as:

`:- (isAlphabet(a), writeln('true')) ; writeln('false').`

That is, if an existing variable `a` is considered `isAlphabet` by other predicates, then it will print
`true`. It will print `false` otherwise. A more realistic example would be:

`:- (isPalindrome([0, 1, 1, 0]), writeln('true')) ; writeln('false').`

The output is supposed to be `true`.

When designing a test case, it is best to only **use only true-false tests and use only one test per file**.
True-false tests are better than enumeration (using forall predicate) tests. This is because the order of enumeration
is not guaranteed in prolog. 
Our grader script ignores whitespace mismataches **but care about the order in which things occur**.
A student will get a +1 score if they pass one test file. So if you write every tests in one file, then a student
will either get a score of 0 or 1.


## Installing dependencies

The prolog script requires swi-prolog. It will try to access the command `swipl` using python subprocess module.
If you are working on mac, you can install swi-prolog as follows:

1. If you don't already have homebrew, install homebrew. Type in the terminal:
   `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
2. Then install swi-prolog using homebrew: `brew install swi-prolog`

If you install using other methods (say you use linux or windows), don't forget to make swipl accessible by adding the path
to your .bash_profile

## How to use

Look in the **demo** folder and spend ten minutes to understand the structure of the grader folder.
The folder has four parts helpers, submissions, drivers, and solutions.
1. **Helpers** run in every tests. The helpers (prolog .pl files) will get run in
    alphabetical order. You cannot have the same predicates defined in different
    files, so if a student is supposed to write the `accepts` predicate, you cannot
    add more rules to `accepts` in the helper files. 
    ([reference](http://www.swi-prolog.org/FAQ/Multifile.html))
    In DFA assignments, one would create `DFAaccepts.pl` helper as follows:
    ```prolog
    accepts(Q, []) :- accepting(Q).
    accepts(Q, [Symbol | Rest]) :- transition(Q, Symbol, NewQ), accepts(NewQ, Rest).
    ```
2. The student **submissions** (.pl files) should go in submissions folder. It will get
   tested against each test case.
3. **Drivers** are your prolog testers files. These .pl files contain prolog
    command(s) to print to stdout to check whether the submission is correct
    ```prolog
    :- forall(spam(X), writeln(X)).
    ```
4. **Solutions** are the solutions for your drivers.
   For each of your driver, you must have a solution file with the same name but with .txt
   extension. These are the expected outputs (correct answers) for your drivers.

WHen you want to test the submissions, you create the four folders and add the necessary components.

You run this python script by calling `python3 grader.py [path-to-folder]` where path-to-folder is
the path to a folder containg the four folders listed above. Assuming that you
have the files in the correct places, it will output the students' score like this:

```
##### Grading submission: [submission file name] #####
CorrectTests: [score] / [total score]
##### Grading submission: [submission file name] #####
CorrectTests: [score] / [total score]
...
```

and store the outputs and errors of each test case in a new folder named results.
You can see an example of a results file in demo-after-run folder.

## Remarks
1. It is often easier to read if you send the output of this script to text file.
2. There are some problems that you should be quite careful using the autograder.
   The man-hare-fox problem in CS81 FA18, for example, has many valid answers.
   The students are only asked to write a code that succesfully finds one of them.
   So the one that they find might not be the same one as the one in the test case.
