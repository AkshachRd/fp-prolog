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
different(X, Y) :- X \= Y.
same_hobbies(Person1, Person2) :-
    likes(Person1, Hobby),
    likes(Person2, Hobby),
    different(Person1, Person2).