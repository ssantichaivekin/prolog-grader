'''
This grader will recieve a folder name. The folder should
contain four sub-folders.

- drivers # containing all the prolog test files (.pl)
- helpers # containing all the prolog code that will run on every test (.pl)
- solutions # answer to the test cases (.txt)
  Note that the test solutions should have the same name as the 
  test drivers. For example, text1.txt is the solution corresponding to
  test.pl driver.
- submittions # the folder containing student submissions (.pl)

(You can look at an example in the demo folder in the repository.)

Create a result folder in the original folder containing all the prolog 
test output and error of all students. Also print out short results and 
student score.
'''

import argparse
import subprocess
import sys
import os

TIMEOUT = 15 # allow 15 seconds per test

def check_driver_solution():
    '''
    For each prolog files in the driver folder, make sure there 
    is a corresponding solution file in the solution folder.
    '''
    complete = True
    for driver in os.listdir("drivers"):
        name, ext = os.path.splitext(driver)
        if (ext != '.pl') :
            print("{} driver is not a prolog file".format(driver))
            print("Please remove the file from the drivers directory.")
            print()
            continue
            
        solution = os.path.join("solutions", "{}.txt".format(name))
        if not os.path.exists(solution):
            print("{} has no matching solution".format(driver), file=sys.stderr)
            print("expected file: {}".format(solution), file=sys.stderr)
            print()
            complete = False

    for submission in os.listdir("submissions"):
        name, ext = os.path.splitext(submission)
        if (ext != '.pl') :
            print("{} submission is not a prolog file".format(submission))
            print("Please remove the file from the submissions directory.")
            print()
            continue

    return complete


def run_prolog(helper_files, submission, driver):
    '''
    Run swi-prolog of one student submission on one test case (one driver),
    along with helper files.
    Return a tuple of output and error of the prolog execution.
    '''
    process = subprocess.run(
        (
            "swipl",
            "--quiet", # no welcome message
            "-t", "halt", # halt after finish
            "-s", # use a script file
            # run all .pl helper files first
            *(os.path.join("helpers", helper) for helper in helper_files),
            # then run the .pl submission file
            os.path.join("submissions", submission),
            # then run the .pl test driver file
            os.path.join("drivers", driver),
        ),
        timeout=TIMEOUT,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    return (process.stdout.decode("utf8"), process.stderr.decode("utf8"))


def run_and_grade_all():
    all_incorrects = []
    os.makedirs("results", exist_ok=True)
    helper_files = os.listdir("helpers")
    for submission in os.listdir("submissions"):
        name, ext = os.path.splitext(submission)
        submission_folder = os.path.join("results", name)
        os.makedirs(submission_folder, exist_ok=True)

        correct = 0
        total = 0

        # create a summary file for each person
        # the detailed information for each test is printed to the summary file
        # a short information is printed to the screen
        with open(os.path.join(submission_folder, "summary.txt"), "w") as summary_file:
            print("summary for {}".format(submission), file=summary_file)
            print("##### grading submission: {} #####".format(submission))

            # grade for each test case
            for driver in os.listdir("drivers"):
                driver_name, _ = os.path.splitext(driver)
                with open(
                    os.path.join("solutions", "{}.txt".format(driver_name))
                ) as f_solution:
                    solution = f_solution.read()
                print("test file: {}".format(driver), file=summary_file)

                # Run prolog
                try:
                    out, err = run_prolog(helper_files, submission, driver)
                except subprocess.TimeoutExpired:
                    print("Submission timeout")
                    out, err = "timeout", "timeout"
                except FileNotFoundError as exception:
                    print(exception)
                    print("This is most likely caused by not having swi-prolog installed")
                    print("First install homebrew, see https://brew.sh for instructions.")
                    print("Then install swipl by typing in the terminal: ")
                    print("brew install swi-prolog")
                    sys.exit(1)

                # write the output and error to file
                with open(
                    os.path.join(submission_folder, "{}-out.txt".format(driver_name)),
                    "w",
                ) as f_out:
                    print("debug", out)
                    f_out.write(out)
                with open(
                    os.path.join(submission_folder, "{}-err.txt".format(driver_name)),
                    "w",
                ) as f_err:
                    f_err.write(err)

                # we ignore whitespace mismatches
                outList = [ x for x in out.split() if x is not None]
                solutionList = [x for x in solution.split() if x is not None]

                if outList == solutionList:
                    correct += 1
                    total += 1
                    print("PASS", file=summary_file)

                else:
                    total += 1
                    print("FAIL", file=summary_file)
                    print("output:", file=summary_file)
                    print(out, file=summary_file)
                    print("solution:", file=summary_file)
                    print(solution, file=summary_file)

            correct_summary = "correct tests: {} / {}".format(correct, total)
            if correct != total :
                all_incorrects.append(name)
            print(correct_summary)
            print(correct_summary, file=summary_file)

    print()
    print("People with not all correct outputs:")
    for incorrect_submission in all_incorrects :
        print("   ", incorrect_submission)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Prolog Grader (requires swipl).")
    parser.add_argument("folderpath",
        help="Path to the folder that contains drivers, helpers, submissions, and "
        "solutions")

    args = parser.parse_args()
    print("Running the prolog grader on {}".format(args.folderpath))
    print()
    os.chdir(args.folderpath)

    try:
        if not check_driver_solution():
            sys.exit(1)
    except:
        print("There is an error in checking whether the driver and the solution for "
              "each test case matches. Please make sure you are in the correct folder "
              "and that the folder is formatted correctly (see readme).")

    run_and_grade_all()
