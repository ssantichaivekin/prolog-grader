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

## Dependencies

swipl, timeout.

If you are working on Mac, you must first install timeout to make this
work. Timeout is used to time the execution of prolog files to make sure
it is not running into an infinite loop. If you already have homebrew
installed, run `brew install coreutils`.

Make sure you also have `swipl` command installed.

## How to use / How it works

Look at the demo-problem1 folder. Inside the folder you will see:
1. Two student submissions **student1-problem1.pl** and **student1-problem1.pl**.
For a file to be considered a submission, it must have the word "problem" in
it and must end with ".pl" extension. 
2. In the folder **tests**, you will see two test cases, named **testA** and **testB**.
These tests have their respective driver **pl** file and solution file and solution
**txt** file. Note the the driver files and the solution files must have a **similar**
name. The driver files must contain the word **driver** and the solution file
must contain the word **solution**. The driver files are the files that runs after 
the assignment to produce the output.

The prolog grader will go through each problem submission, grade them against
each pair of driver and solution, and then produce a summary file.

If you run `zsh grader.zsh ./demo-problem1`, it will populate the folder with 
grading results to become like the folder **after-demo-problem1** and print the
following:
```
##### Grading submission: ./demo/student1-problem1.pl #####
CorrectTests: 1 / 2
##### Grading submission: ./demo/student2-problem1.pl #####
CorrectTests: 2 / 2
```

Remark :
1. If you are working on windows, the grader probably wouldn't work.
2. The folder of driver and solutions must be named **tests**.
3. This grader have not been rigorously tested. In fact, it has not been tested at all.



   