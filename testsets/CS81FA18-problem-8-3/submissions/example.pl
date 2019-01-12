accepting(qend).

transition(q0, epsilon, epsilon, $, qx).

transition(qx, 1, c, epsilon, qy).
transition(qx, 1, epsilon, u, qy).

transition(qy, epsilon, c, epsilon, qx).
transition(qy, epsilon, epsilon, u, qx).

transition(qx, 0, epsilon, c, qx).
transition(qx, 0, u, epsilon, qx).

transition(qx, epsilon, $, epsilon, qend).
