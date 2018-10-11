import subprocess
import sys
import os

TIMEOUT = 15


def check_driver_solution():
    complete = True

    for driver in os.listdir("drivers"):

        name, ext = os.path.splitext(driver)
        solution = os.path.join("solutions", "{}.txt".format(name))

        if not os.path.exists(solution):
            print("{} has no matching solution".format(driver), file=sys.stderr)
            print("expected file: {}".format(solution), file=sys.stderr)
            complete = False

    return complete


def run_prolog(helper_files, submission, driver):
    process = subprocess.run(
        (
            "swipl",
            "--quiet",
            "-t",
            "halt",
            "-s",
            *(os.path.join("helpers", helper) for helper in helper_files),
            os.path.join("submissions", submission),
            os.path.join("drivers", driver),
        ),
        timeout=TIMEOUT,
        capture_output=True,
    )
    return (process.stdout.decode("utf8"), process.stderr.decode("utf8"))


def run_and_grade_all():
    try:
        os.mkdir("results")
    except FileExistsError:
        pass

    helper_files = os.listdir("helpers")
    for submission in os.listdir("submissions"):
        name, ext = os.path.splitext(submission)
        submission_folder = os.path.join("results", name)

        try:
            os.mkdir(submission_folder)
        except FileExistsError:
            pass

        correct = 0
        total = 0

        with open(os.path.join(submission_folder, "summary.txt"), "w") as summary_file:
            print("summary for {}".format(submission), file=summary_file)
            print("##### grading submission: {} #####".format(submission))

            for driver in os.listdir("drivers"):
                driver_name, _ = os.path.splitext(driver)
                with open(
                    os.path.join("solutions", "{}.txt".format(driver_name))
                ) as f_solution:
                    solution = f_solution.read()
                print("test file: {}".format(driver), file=summary_file)

                try:
                    out, err = run_prolog(helper_files, submission, driver)
                except subprocess.TimeoutExpired:
                    out, err = "", ""

                with open(
                    os.path.join(submission_folder, "{}-out.txt".format(driver_name)),
                    "w",
                ) as f_out:
                    f_out.write(out)
                with open(
                    os.path.join(submission_folder, "{}-err.txt".format(driver_name)),
                    "w",
                ) as f_err:
                    f_err.write(err)

                if out.strip().split("\n") == solution.strip().split("\n"):
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
            print(correct_summary)
            print(correct_summary, file=summary_file)


if __name__ == "__main__":
    if not check_driver_solution():
        sys.exit(1)

    run_and_grade_all()
