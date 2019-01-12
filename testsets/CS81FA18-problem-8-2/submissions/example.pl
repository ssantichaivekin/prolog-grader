accepting(qend).

transition(q0, epsilon, epsilon, $, q1).
transition(q1, 0, epsilon, 0, q1).
transition(q1, epsilon, epsilon, epsilon, q2a).
transition(q2a, 1, 0, epsilon, q2b).
transition(q2b, epsilon, 0, epsilon, q2a).
transition(q2a, epsilon, $, epsilon, qend).