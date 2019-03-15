/*Exercice 1*/
subs(chat,felin).
subs(lion,felin).
subs(chien,canide).
subs(canide,chien).
subs(souris,mammifere).
subs(felin,mammifere).
subs(canide,mammifere).
subs(mammifere,animal).
subs(canari,animal).
subs(animal,etreVivant).
subs(and(animal,plante),nothing).
subs(lion,carnivoreExc).
subs(carnivoreExc,predateur).
subs(animal,some(mange)).
subs(and(all(mange,nothing),some(mange)),nothing).
subs(and(some(aMaitre),animal),pet).
subs(pet,some(aMaitre)).
subs(some(aMaitre),all(aMaitre,humain)).
subs(chihuahua,and(chien,pet)).


equiv(carnivoreExc,all(mange,animal)).
equiv(herbivoreExc,all(mange,plante)).

instC(felix,chat).
instC(pierre,humain).
instC(princesse,chihuahua).
instC(marie,humain).
instC(jerry,souris).
instC(titi,canari).
instR(felix,mange,jerry).
instR(felix,mange,jerry).
instR(felix,aMaitre,pierre).
instR(princesse,aMaitre,marie).

/*Exercice 2*/
subsS1(C,C).
subsS1(C,D):-subs(C,D),C\==D.
subsS1(C,D):-subs(C,E),subsS1(E,D).

subsS(C,all(X,Y)):-subs(Z,Y),subs(C,D),equiv(D,all(X,Z)).
subsS(all(X,Y),C):-subs(Z,Y),subs(C,D),equiv(all(X,Z),D).
subsS(C,all(X,Y)):-subs(Y,Z),subs(C,D),equiv(D,all(X,Z)).
subsS(all(X,Y),C):-subs(Y,Z),subs(C,D),equiv(all(X,Z),D).

subsS(C,D):-subs(C,E),equiv(E,D).
subsS(C,D):-subsS(C,D,[C]).
subsS(C,C,_).
subsS(C,D,_):-subs(C,D),C\==D.
subsS(C,D,L):-subs(C,E),not(member(E,L)),subsS(E,D,[E|L]),E\==D.

subsS(C,and(D1,D2),L):-D1\=D2,subsS(C,D1,L),subsS(C,D2,L). 
subsS(C,D,L):-subs(and(D1,D2),D),E=and(D1,D2),not(member(E,L)), subsS(C,E,[E|L]),E\==C.
subsS(and(C,C),D,L):-nonvar(C),subsS(C,D,[C|L]).
subsS(and(C1,C2),D,L):-C1\=C2,subsS(C1,D,[C1|L]).
subsS(and(C1,C2),D,L):-C1\=C2,subsS(C2,D,[C2|L]).
subsS(and(C1,C2),D,L):-subs(C1,E1),E=and(E1,C2),not(member(E,L)),subsS(E,D,[E|L]),E\==D.
subsS(and(C1,C2),D,L):-Cinv=and(C2,C1),not(member(Cinv,L)),subsS(Cinv,D,[Cinv|L]).

/*Exercice 4*/
/*1*/

