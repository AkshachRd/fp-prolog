member(X, [X|_]) :- !.
member(X, [_|L]) :- member(X, L).

fib(N, F) :-
    integer(N),
    N >= 1,
    fib_helper(N, F),
    !.
fib(_, _) :-
    write('error'), nl,
    !.

fib_helper(1, 1) :- !.
fib_helper(2, 1) :- !.
fib_helper(N, F) :-
    N > 2,
    N1 is N - 1,
    N2 is N - 2,
    fib_helper(N1, F1),
    fib_helper(N2, F2),
    F is F1 + F2.


shell_sort(List, SortedList) :-
    length(List, N),
    generate_gaps(N, Gaps),
    shell_sort_gaps(List, Gaps, SortedList).

generate_gaps(N, Gaps) :-
    N > 1,
    generate_gaps_helper(N, Gaps).

generate_gaps_helper(N, []) :-
    Gap is N // 2,
    Gap < 1.
generate_gaps_helper(N, [Gap|Gaps]) :-
    Gap is N // 2,
    Gap >= 1,
    generate_gaps_helper(Gap, Gaps).

shell_sort_gaps(List, [], List).
shell_sort_gaps(List, [Gap|Gaps], SortedList) :-
    gapped_insertion_sort(List, Gap, PartiallySorted),
    shell_sort_gaps(PartiallySorted, Gaps, SortedList).

gapped_insertion_sort(List, Gap, SortedList) :-
    gapped_insertion_sort_helper(List, Gap, 0, SortedList).

gapped_insertion_sort_helper(List, Gap, Index, SortedList) :-
    length(List, Len),
    Index < Len,
    NextIndex is Index + 1,
    insert_gapped(List, Gap, Index, ListAfterInsert),
    gapped_insertion_sort_helper(ListAfterInsert, Gap, NextIndex, SortedList).
gapped_insertion_sort_helper(SortedList, _, Index, SortedList) :-
    length(SortedList, Len),
    Index >= Len.

insert_gapped(List, Gap, Index, NewList) :-
    nth0(Index, List, Elem),
    shift_element(List, Elem, Index, Gap, NewList).

shift_element(List, _, Index, Gap, List) :-
    Index < Gap.
shift_element(List, Elem, Index, Gap, NewList) :-
    PrevIndex is Index - Gap,
    nth0(PrevIndex, List, PrevElem),
    ( Elem < PrevElem ->
        replace(List, Index, PrevElem, TempList),
        replace(TempList, PrevIndex, Elem, NewList)
    ;
        NewList = List
    ).

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

sort_3 :-
    write('list?        '),
    read(List),
    shell_sort(List, Sorted),
    write('answer: '),
    write(Sorted), nl.

sort_4_1 :-
    write('list?        '),
    read(List),
    naive_sort(List, Sorted),
    write('answer: '),
    write(Sorted), nl.

naive_sort(List, Sorted) :-
    permutation(List, Sorted),
    is_sorted(Sorted),
    !.

is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|T]) :-
    X =< Y,
    is_sorted([Y|T]).

sort_4_2 :-
    write('list?        '),
    read(List),
    bubble_sort(List, Sorted),
    write('answer: '),
    write(Sorted), nl.

bubble_sort(List, Sorted) :-
    bubble_pass(List, List1, Swapped),
    ( Swapped = true ->
        bubble_sort(List1, Sorted)
    ;
        Sorted = List1
    ).

bubble_pass([X,Y|Rest], [Y|Result], true) :-
    X > Y,
    !,
    bubble_pass([X|Rest], Result, _).
bubble_pass([X|Rest], [X|Result], Swapped) :-
    bubble_pass(Rest, Result, Swapped).
bubble_pass([], [], false).
bubble_pass([X], [X], false).


sort_4_3 :-
    write('list?        '),
    read(List),
    insertion_sort(List, Sorted),
    write('answer: '),
    write(Sorted), nl.

insertion_sort(List, Sorted) :-
    insertion_sort_helper(List, [], Sorted).

insertion_sort_helper([], Acc, Acc).
insertion_sort_helper([H|T], Acc, Sorted) :-
    insert_in_order(H, Acc, NewAcc),
    insertion_sort_helper(T, NewAcc, Sorted).

insert_in_order(X, [], [X]).
insert_in_order(X, [Y|T], [X,Y|T]) :-
    X =< Y.
insert_in_order(X, [Y|T], [Y|T1]) :-
    X > Y,
    insert_in_order(X, T, T1).

sort_4_4 :-
    write('list?        '),
    read(List),
    quick_sort(List, Sorted),
    write('answer: '),
    write(Sorted), nl.

quick_sort([], []).
quick_sort([H|T], Sorted) :-
    partition(T, H, Smaller, Greater),
    quick_sort(Smaller, SortedSmaller),
    quick_sort(Greater, SortedGreater),
    append(SortedSmaller, [H|SortedGreater], Sorted).

partition([], _, [], []).
partition([X|T], Pivot, [X|Smaller], Greater) :-
    X =< Pivot,
    partition(T, Pivot, Smaller, Greater).
partition([X|T], Pivot, Smaller, [X|Greater]) :-
    X > Pivot,
    partition(T, Pivot, Smaller, Greater).

common(L1, L2, L3) :-
    append(L1, L2, Combined),
    sort(Combined, L3).

count_occurrences(Elem, List, Count) :-
    include(==(Elem), List, FilteredList),
    length(FilteredList, Count).

compare_counts(Order, Count1-_, Count2-_) :-
    (   Count1 > Count2 -> Order = '<'    % Place Count1 before Count2
    ;   Count1 < Count2 -> Order = '>'    % Place Count2 before Count1
    ;   Order = '='                       % Counts are equal
    ).

most_oft(List, X) :-
    List \= [],
    setof(Elem, member(Elem, List), UniqueElems),
    findall(Count-Elem,
            (member(Elem, UniqueElems),
             count_occurrences(Elem, List, Count)),
            Counts),
    predsort(compare_counts, Counts, SortedCounts),
    SortedCounts = [ _-X | _ ].
