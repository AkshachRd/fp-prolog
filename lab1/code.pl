% 0
parent(bill, joe).
parent(sue, joe).
parent(bill, ann).
parent(sue, ann).
parent(paul, jim).
parent(mary, jim).
parent(joe, tammy).
parent(ann, bob).
parent(jim, bob).

male(bill).
male(joe).
male(paul).
male(jim).
male(bob).

female(sue).
female(mary).
female(ann).
female(tammy).

% 1
son(X) :- parent(Y, X), male(X).

% 2
grandma(X, Y) :- parent(X, Z), parent(Z, Y), female(X).

% 3
grandson(X, Y) :- parent(Y, Z), parent(Z, X), male(X).

% 4
different(X, Y) :- X \= Y.
sister(X, Y) :- parent(P, X), parent(P, Y), female(X), different(X, Y).

% 5
aunt(X, Y) :- parent(P, Y), sister(X, P).

% 6.
cousin(X, Y) :- parent(PX, X), parent(PY, Y), parent(P, PX), parent(P, PY), different(PX, PY).

% 7
likes(ellen, reading).
likes(john, computers).
likes(john, badminton).
likes(john, photo).
likes(john, reading).
likes(leonard, badminton).
likes(eric, swimming).
likes(eric, badminton).
likes(eric, chess).
likes(eric, game).
likes(paul, swimming).

% 8
four_hobbies(Person) :-
    findall(Hobby, likes(Person, Hobby), Hobbies),
    length(Hobbies, 4).

% 9
same_hobbies(Person1, Person2) :-
    likes(Person1, Hobby),
    likes(Person2, Hobby),
    different(Person1, Person2).
