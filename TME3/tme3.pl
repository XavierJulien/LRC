
/********EXERCICE 2 *********/

/**Concatene(X, Y, Z)**/
/*Cas d'arret */
concatene([], L, L).
/*Récursion*/
concatene([X | L1],  L2, [X | L3]) :- concatene(L1, L2, L3). 



/**Inverse(X, Y)**/
inverse([], []).
inverse([X|L1], LR):- inverse(L1, L2),concatene(L2,[X],LR).
/*
?- inverse([a, b, c], LR).
LR = [c, b, a].
*/



/**Supprime(X, Y, Z)**/
supprime([],_,[]).
supprime([Y | L1], Y, LR) :- supprime(L1,Y,LR).
supprime([X | L1], Y, LR) :- X\=Y,supprime(L1,Y,L2),concatene([X],L2,LR).
/*
?- supprime([a, b, a, c], a, LR).
LR = [b, c] .
*/



/**Filtre(L1, L2,L3)**/
filtre(L,[],L).
filtre(L,[X|L1],LR) :- supprime(L,X,L2),filtre(L2,L1,LR).
/*
?- filtre([1,2,3,4,3,2,1,2,3,4,2,3,2,1,1],[2,4], L).
L = [1, 3, 3, 1, 3, 3, 1, 1] ;
*/


/********EXERCICE 3 *********/
palindrome([]).
palindrome(L) :- inverse(L,LR), LR==L.
/*
?- palindrome([l,a,v,a,l]).
true.

?- palindrome([n,a,v,a,l]).
false.

?- palindrome([n,o,n]).
true.
*/

palindrome2([]).
palindrome2([X|[]]) :- concatene(LR,[X],[LR|X]).
palindrome2([X|LR]) :- palindrome2(LR),concatene([],[X],LR).
