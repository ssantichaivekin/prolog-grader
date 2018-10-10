A zsh prolog grader.

Run by calling `zsh grader.zsh [folder_to_be_graded]`. Assuming that you
have the files in the correct places, it will output something like this:
```
##### Grading submission: [submission file name] #####
CorrectTests: [score] / [total score]
##### Grading submission: [submission file name] #####
CorrectTests: [score] / [total score]
...
```
and store the output of test cases in a folder for each student submission.

If you clone the repository and run `zsh grader.zsh ./demo`, it will 
populate the folder with grading results to become like the folder **after-demo-problem1** 
and print the following:
```
##### Grading submission: demo/submissions/student1.pl #####
CorrectTests: 1 / 3
##### Grading submission: demo/submissions/student2.pl #####
CorrectTests: 3 / 3
```

## Dependencies

zsh, swipl, timeout.

If you are working on Mac, you must first install zsh and timeout to make this
work. Run `brew install zsh`.

Timeout is used to time the execution of prolog files to make sure
it is not running into an infinite loop. If you already have homebrew
installed, run `brew install coreutils`.

Make sure you also have `swipl` command installed and accessible by zsh.
If you have swipl prolog installed but cannot access it by the command line,
try adding this line
```zsh
PATH=$PATH:/Applications/SWI-Prolog.app/Contents/MacOS
```
to your ~/.bash_profile and ~/.zshrc

## How to use / How it works

Look at the structure of the folder in **demo**.
The folder has four parts helpers, submissions, drivers, and solutions.
We will explain what one should put in each folder.
1. Put all your prolog helper files in helpers. The helpers will get run in
    alphabetical order. Note that due to [how prolog works](http://www.swi-prolog.org/FAQ/Multifile.html),
    you cannot define the same predicates in different files.
    In CS81, DFA assignment, one would create a `DFAaccepts.pl` file in the
    helper folder containing
    ```prolog
    accepts(Q, []) :- accepting(Q).
    accepts(Q, [Symbol | Rest]) :- transition(Q, Symbol, NewQ), accepts(NewQ, Rest).
    ```
2. Put the student submissions in submissions folder.
3. Put your driver (tester) prolog files in the drivers folder. These files contain
    command(s) to print to stdout like
    ```prolog
    :- forall(spam(X), writeln(X)).
    ```
4. For each of your driver, you must have a solution file with the same name but with .txt
extension. These are the expected outputs (correct answers) for your drivers.

Then, you run the grader to grade all student files
```zsh
zsh grader.zsh foldername
```
In our example, our foldername is ./demo, so we will run
```zsh
zsh grader.zsh ./demo
```
This will add a new folder to demo named `results` containing the summary and the outputs
for each students. This is an example of a summary with three test cases. The student
passes only the second and have wrong outputs for first and third.
```
Summary for demo-after-run/submissions/student1.pl
test file: demo-after-run/drivers/spam.pl
FAIL
Output :
a
b
b
c
d
Solution :
a
b
c
d
e
f
g
test file: demo-after-run/drivers/testA.pl
PASS
test file: demo-after-run/drivers/testB.pl
FAIL
Output :
a
b
b
c
d
Solution :
a
b
c
d
e
f
g

CorrectTests: 1 / 3
```

Remark :
1. Becareful! This grader is very sensitive to filenames and file
   extensions. Use .pl and .txt extensions only.
2. If you are working on windows, the grader probably wouldn't work.
3. This grader has not been rigorously tested.




   