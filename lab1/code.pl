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

% b) Найти бабушку для bob.
grandmother(X, Y) :- parent(X, Z), parent(Z, Y), female(X).

% c) Найти внука.
grandson(X, Y) :- parent(Y, Z), parent(Z, X), male(X).

% d) Найти сестру для jim.
different(X, Y) :- X \= Y.
sister(X, Y) :- parent(P, X), parent(P, Y), female(X), different(X, Y), halt.

% e) Определите отношение "тётя".
aunt(X, Y) :- parent(P, Y), sister(X, P).

% f) Определите отношение "кузин".
cousin(X, Y) :- parent(PX, X), parent(PY, Y), parent(P, PX), parent(P, PY), different(PX, PY).

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

% b) Найти тех, кто имеет четыре хобби.
has_four_hobbies(Person) :-
    findall(Hobby, likes(Person, Hobby), Hobbies),
    length(Hobbies, 4).

% c) Найти тех, у кого одинаковые хобби.
same_hobbies(Person1, Person2) :-
    likes(Person1, Hobby),
    likes(Person2, Hobby),
    different(Person1, Person2).
