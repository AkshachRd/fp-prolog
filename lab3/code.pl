trim([_|Rest], L2) :-
    append(L2, [_], Rest).

first_last([First|Rest], [Last|NewRest]) :-
    append(Middle, [Last], Rest),
    append(Middle, [First], NewRest).

total([], 1).
total([X | Xs], N) :-
    total(Xs, N1),
    N is X * N1.

place(X, List, [X | List]).
place(X, [Y | Ys], [Y | Zs]) :-
    place(X, Ys, Zs).

double([], []).
double([X | Xs], [X, X | Ys]) :-
    double(Xs, Ys).

split([], [], []).
split([X | Xs], Evens, Odds) :-
    split(Xs, Evens1, Odds1),
    ( 0 is X mod 2 ->
        Evens = [Evens1 | X],
        Odds = Odds1
    ;
        Evens = Evens1,
        Odds = [Odds1 | X]
    ).

repeat3(L1, L2) :-
    first_last(L1, SwappedL1),
    SwappedL1 = [First | _],
    L1 = [Last | _],
    replicate(First, 2, FirstList),
    replicate(Last, 2, LastList),
    append([FirstList, SwappedL1, LastList], L2).

replicate(_, 0, []).
replicate(X, N, [X | Xs]) :-
    N > 0,
    N1 is N - 1,
    replicate(X, N1, Xs).

combi([X], _, [X]).
combi([X1, X2 | Xs], [Y | Ys], [X1, Y | Zs]) :-
    combi([X2 | Xs], Ys, Zs).
combi([X1, X2 | Xs], [], [X1, X2 | Xs]).
