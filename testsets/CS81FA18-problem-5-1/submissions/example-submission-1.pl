accepting(q0).
transition(q0,0, q3).
transition(q0,1, q1).

transition(q1,0, q4).
transition(q1,1, q2).

transition(q2,0, q5).
transition(q2,1, q0).

transition(q3,0, q0).
transition(q3,1, q4).

transition(q4,0, q1).
transition(q4,1, q5).

transition(q5,0, q2).
transition(q5,1, q3).
