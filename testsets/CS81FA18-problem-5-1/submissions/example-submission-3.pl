accepting(q0).

transition(q0, 0, q10).
transition(q0, 1, q01).
transition(q01, 0, q11).
transition(q01, 1, q02).
transition(q02, 0, q12).
transition(q02, 1, q0).
transition(q10, 0, q0).
transition(q10, 1, q11).
transition(q11, 0, q01).
transition(q11, 1, q12).
transition(q12, 0, q02).
transition(q12, 1, q10).
