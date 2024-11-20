% Horizontal lines
seg(1, point(1, 11), point(14, 11)).
seg(2, point(2, 4), point(13, 4)).
seg(3, point(2, 2), point(9, 2)).
seg(5, point(7, 10), point(13, 10)).

% Vertical lines
seg(4, point(3, 1), point(3, 10)).
seg(6, point(8, 0), point(8, 13)).
seg(7, point(10, 3), point(10, 12)).
seg(8, point(11, 3), point(11, 13)).
seg(9, point(12, 2), point(12, 12)).

horiz(N) :-
    seg(N, point(X1, Y), point(X2, Y)),
    X1 =\= X2.

vertical(N) :-
    seg(N, point(X, Y1), point(X, Y2)),
    Y1 =\= Y2.

cross(N, M, point(X, Y), NL, ML) :-
    horiz(N), vertical(M),
    seg(N, point(HX1, Y), point(HX2, Y)),
    seg(M, point(X, VY1), point(X, VY2)),
    min(HX1, HX2) =< X, X =< max(HX1, HX2),
    min(VY1, VY2) =< Y, Y =< max(VY1, VY2),
    segment_length(NL, N),
    segment_length(ML, M).

cross(N, M, point(X, Y), NL, ML) :-
    vertical(N), horiz(M),
    seg(N, point(X, VY1), point(X, VY2)),
    seg(M, point(HX1, Y), point(HX2, Y)),
    min(VY1, VY2) =< Y, Y =< max(VY1, VY2),
    min(HX1, HX2) =< X, X =< max(HX1, HX2),
    segment_length(NL, N),
    segment_length(ML, M).

segment_length(L, N) :-
    seg(N, point(X1, Y1), point(X2, Y2)),
    (Y1 =:= Y2 -> L is abs(X2 - X1);
     X1 =:= X2 -> L is abs(Y2 - Y1)).

per_sq(A, B, C, D, P, S) :-
    vertical(A), vertical(C), A \= C,
    horiz(B), horiz(D), B \= D,
    cross(B, A, point(X1, Y1), _, _),
    cross(B, C, point(X2, Y2), _, _),
    cross(D, A, point(X3, Y3), _, _),
    cross(D, C, point(X4, Y4), _, _),
    X1 = X3, Y1 = Y2, X2 = X4, Y3 = Y4,
    Width is abs(X1 - X2),
    Height is abs(Y1 - Y3),
    P is 2 * (Width + Height),
    S is Width * Height.