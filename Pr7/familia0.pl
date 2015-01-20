dd(juan, maria, rosa, m).
dd(juan, maria, luis, h).
dd(jose, laura, pilar, m).
dd(luis, pilar, miguel, h).
dd(miguel,isabel,jaime,h).
dd(pedro, rosa, pablo, h).
dd(pedro, rosa, begoña, m).
padre(X, Y):- dd(X, _, Y, _).
madre(X, Y):- dd(_, X, Y, _).
hijo(X, Y):- dd(Y, _, X, h).
hijo(X, Y):- dd(_, Y, X, h).
hija(X, Y):- dd(Y, _, X, m).
hija(X, Y):- dd(_, Y, X, m).
hermano(X,Y):- hijo(X,Z),hija(Y,Z).
hermano(X,Y):- hijo(X,Z),hijo(Y,Z), X is not Y.
hermana(X,Y):- hija(X,Z),hijo(Y,Z).
hermana(X,Y):- hija(X,Z),hija(Y,Z), X is not Y.
progenitor(X,Y):- padre(X,Y);madre(X,Y).
abuelo(X,Y):- padre(X,Z),padre(Z,Y).
abuelo(X,Y):- padre(X,Z),madre(Z,Y).
abuela(X,Y):- madre(X,Z),padre(Z,Y).
abuela(X,Y):- madre(X,Z),madre(Z,Y).
primo(X,Y):- hijo(X,Z),hermano(Z,W),padre(W,Y).
primo(X,Y):- hijo(X,Z),hermana(Z,W),padre(W,Y).
primo(X,Y):- hijo(X,Z),hermano(Z,W),madre(W,Y).
primo(X,Y):- hijo(X,Z),hermana(Z,W),madre(W,Y).
prima(X,Y):- hija(X,Z),hermano(Z,W),padre(W,Y).
prima(X,Y):- hija(X,Z),hermana(Z,W),padre(W,Y).
prima(X,Y):- hija(X,Z),hermano(Z,W),madre(W,Y).
prima(X,Y):- hija(X,Z),hermana(Z,W),madre(W,Y).
ascendiente(X,Y):- progenitor(Y,X).
ascendiente(X,Y):- progenitor(Z,X),ascendiente(Z,Y).