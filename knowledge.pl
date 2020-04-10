/*
    Author: Gautam Gadipudi
    RIT ID: gg7148

    Please find results at the bottom.
*/

/*FACTS*/
%-----------------------

male('George').
male('Philip').
male('Spencer').
male('Charles').
male('Mark').
male('Andrew').
male('Edward').
male('William').
male('Harry').
male('Peter').
male('James').

female('Mum').
female('Elizabeth').
female('Margaret').
female('Kydd').
female('Diana').
female('Anne').
female('Sarah').
female('Sophie').
female('Zara').
female('Beatrice').
female('Eugenie').
female('Louise').

%-----------------------

spouse_to('George', 'Mum').
spouse_to('Spencer', 'Kydd').
spouse_to('Elizabeth', 'Philip').
spouse_to('Diana', 'Charles').
spouse_to('Anne', 'Mark').
spouse_to('Andrew', 'Sarah').
spouse_to('Edward', 'Sophie').

%-----------------------

child('Elizabeth', 'George').
child('Elizabeth', 'Mum').

child('Margaret', 'George').
child('Margaret', 'Mum').

child('Charles', 'Elizabeth').
child('Charles', 'Philip').

child('Anne', 'Elizabeth').
child('Anne', 'Philip').

child('Andrew', 'Elizabeth').
child('Andrew', 'Philip').

child('Edward', 'Elizabeth').
child('Edward', 'Philip').

child('Diana', 'Spencer').
child('Diana', 'Kydd').

child('William', 'Diana').
child('William', 'Charles').

child('Harry', 'Diana').
child('Harry', 'Charles').

child('Zara', 'Anne').
child('Zara', 'Mark').

child('Peter', 'Anne').
child('Peter', 'Mark').

child('Beatrice', 'Andrew').
child('Beatrice', 'Sarah').

child('Eugenie', 'Andrew').
child('Eugenie', 'Sarah').

child('Louise', 'Edward').
child('Louise', 'Sophie').

child('James', 'Edward').
child('James', 'Sophie').

%-----------------------

sibling_to('Elizabeth', 'Margaret').
sibling_to('Anne', 'Charles').
sibling_to('Andrew', 'Charles').
sibling_to('Edward', 'Charles').
sibling_to('Andrew', 'Anne').
sibling_to('Edward', 'Anne').
sibling_to('Andrew', 'Edward').
sibling_to('William', 'Harry').
sibling_to('Zara', 'Peter').
sibling_to('Beatrice', 'Eugenie').
sibling_to('James', 'Louise').

%-----------------------

/*PREDICATES*/
%-----------------------
spouse(A, B) :-
    spouse_to(B, A);
    spouse_to(A, B).

sibling(A, B) :-
    sibling_to(B, A);
    sibling_to(A, B).

grand_child(C, A) :-
    child(B, A),
    child(C, B).

great_grand_parent(D, A) :-
    child(A, B),
    child(B, C),
    child(C, D).

ancestor(A, X) :-
    child(X, A);
    child(B, A),
    ancestor(B, X).

brother(X, Y) :-
    male(X),
    sibling(X, Y).

sister(X, Y) :-
    female(X),
    sibling(X, Y).

daughter(X, Y) :-
    female(X),
    child(X, Y).

daughter(X, Y) :-
    daughter(X, spouse(Z, Y)).

son(X, Y) :-
    male(X),
    child(X, Y).

son(X, Y) :- 
    son(X, spouse(Z, Y)).

first_cousin(C, D) :-
    child(C, P1),
    child(D, P2),
    sibling(P1, P2).

brother_in_law(B, X) :-
    spouse(X, M),
    brother(B, M).

sister_in_law(S, X) :-
    spouse(X, M),
    sister(S, M).

aunt(A, C) :-
    child(C, P),
    sister(A, P);
    sister_in_law(A, P).

uncle(U, C) :-
    child(C, P),
    brother(A, P);
    brother_in_law(A, P).

grand_children_list(X) :-
    setof(Y, grand_child(Y, X), List),
    format('Grand children of ~w are ~w', [X, List]).

brother_in_law_list(X) :-
    setof(Y, brother_in_law(Y, X), List),
    format('Brother in laws of ~w are ~w', [X, List]).

great_grand_parent_list(X) :-
    setof(Y, great_grand_parent(Y, X), List),
    format('Great grand parents of ~w are ~w', [X, List]).

ancestor_list(X) :-
    setof(Y, ancestor(Y, X), List),
    format('Ancestors of ~w are ~w', [X, List]).

%-----------------------
/*
RESULTS:

| ?- grand_children_list('Elizabeth').
Grand children of Elizabeth are [Beatrice,Eugenie,Harry,James,Louise,Peter,William,Zara]

| ?- brother_in_law_list('Diana').
Brother in laws of Diana are [Andrew,Edward]

| ?- great_grand_parent_list('Zara').
Great grand parents of Zara are [George,Mum]

| ?- ancestor_list('Eugenie').
Ancestors of Eugenie are [Andrew,Elizabeth,George,Mum,Philip,Sarah]
*/