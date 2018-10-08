In order to run the prolog grader script, you will need four things:
1. the grader script itself (grader.zsh)
2. the prolog submission file to be graded (\*problem\*.pl)
3. the prolog driver function file (driver-{0..9}.pl)
4. the expected output (solution) file to the driver function (solution-{0..9}.out)

The grader script will be provided, which will search for all files that its name
matches `*problem*.pl` and all driver function files `driver-{0..9}.pl`. For each 
pair of files, it will run the concatenation of submission file and the driver file
and write its output to `*problem*-{0..9}.out` (the same filename as the submission 
file, but add a number to the back and change `.pl` to `.out`).

Then the script will compare the `.out` outputs with the correct outputs. It will then
write a score summary for each of the submission file.

The two said parts shall be in separate functions in the zsh script. The person writing
and maintaining the script shall have basic shell knowledge. Minimum prolog 
knowledge is required.