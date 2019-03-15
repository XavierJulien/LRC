pere(antonio, julien).
pere(antonio, tania).
pere(jose, antonio).
pere(jose3, jose).
pere(jose2, marie).
mere(maria,antonio).
mere(maria2, marie).
mere(marie, julien).
mere(marie, tania).



parent(X,Y) :- mere(X,Y).
parent(X,Y) :- pere(X,Y).

/*
?- parent(marie, julien).
true .

?- parent(marie, X).
X = julien ;
X = tania ;
X = gabriel ;
false.

*/


parents(X, Y, Z) :- mere(Y,Z), pere(X,Z).

/*
?- parents(X, Y, julien).
X = antonio,
Y = marie.

?- parents(X, Y, jacques).
false.

?- parents(antonio, marie, A).
A = julien ;
false.

*/



grandPere(X,Y) :- pere(X,Z), parent(Z,Y).

/*
?- grandPere(X, julien).
X = jose ;
X = jose2 ;
false.

*/

frereOuSoeur(X,Y) :- parents(A,B,X), parents(A,B,Y).

/*
frereOuSoeur(tania, julien).
true.

*/

ancetre(X,Y) :- parent(X,Y).
ancetre(X,Y) :- ancetre(Z,Y).
