%Representación de estados del problema del río chino.

%Definición de los estados: 

% Para definir el estado he decicido representar solo un lado del río
% Se empieza el problema en la orilla izquierda
% 0 Representa que el elemento está en la orilla derecha
% 1 o 2 representa el número de 'personas' del tipo en la orilla izquierda
% estado(padre,madre,hijos,hijas,policia,ladron,barco)

%Para evitar añadir complejidad al problema, no se definirá la posiblidad de intentar un trayecto de peligro, como madre e hijo, o padre e hija, o ladron y algo que no sea policia

%---------------------------------------------------------------------
inicial(estado(1,1,2,2,1,1,1)). %definicion del estado inicial en prolog
objetivo(estado(0,0,0,0,0,0,_)). %definicion del estado final en prolog

%---------------------------------------------------------------------

%-----------------------ESTADOS DE PELIGRO----------------------------

%Padre con alguna hija en la orilla izquierda
peligro(estado(P,M,_,Ha,_,_,_)):-P>0,M<1,Ha>0.

%Padre con alguna hija en la orilla derecha
peligro(estado(P,M,_,Ha,_,_,_)):-P<1,M>0,Ha<2.

%Madre con algun hijo en la orilla izquierda
peligro(estado(P,M,Ho,_,_,_,_)):-M>0,P<1,Ho>0.

%Madre con algun hijo en la orilla derecha
peligro(estado(P,M,Ho,_,_,_,_)):-M<1,P>0,Ho<2.

%Ladrón no solo y sin el policía en la orilla izquierda
peligro(estado(P,_,_,_,Pol,L,_)):-P>0,Pol<1,L>0.
peligro(estado(_,M,_,_,Pol,L,_)):-M>0,Pol<1,L>0.
peligro(estado(_,_,Ho,_,Pol,L,_)):-Ho>0,Pol<1,L>0.
peligro(estado(_,_,_,Ha,Pol,L,_)):-Ha>0,Pol<1,L>0.

%Ladrón no solo y sin el policía en la orilla derecha
peligro(estado(P,_,_,_,Pol,L,_)):-P<1,Pol>0,L<1.
peligro(estado(_,M,_,_,Pol,L,_)):-M<1,Pol>0,L<1.
peligro(estado(_,_,Ho,_,Pol,L,_)):-Ho<2,Pol>0,L<1.
peligro(estado(_,_,_,Ha,Pol,L,_)):-Ha<2,Pol>0,L<1.

%-----------------------MOVIMIENTOS-----------------------------------
%Mueve al ladrón y al policía del lado izquierdo al derecho.
%Esto en ningún caso crea un estado de peligro.
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(P,M,Ho,Ha,NPol,NLad,0)):-Pol>0,Lad>0,NPol is Pol-1,NLad is Lad-1,not(peligro(estado(P,M,Ho,Ha,NPol,NLad,0))).

%Mueve al ladrón y al policia del lado derecho al izquierdo.
%Tampoco crea un estado de peligro.
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(P,M,Ho,Ha,NPol,NLad,1)):-Pol<1,Lad<1,NPol is Pol+1,NLad is Lad+1,not(peligro(estado(P,M,Ho,Ha,NPol,NLad,1))).

%Mueve al policia del lado izquierdo al derecho.
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(P,M,Ho,Ha,NPol,Lad,0)):-Pol>0,NPol is Pol-1,not(peligro(estado(P,M,Ho,Ha,NPol,Lad,0))).

%Mueve al policia del lado derecho al izquierdo.
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(P,M,Ho,Ha,NPol,Lad,1)):-Pol<1,NPol is Pol+1,not(peligro(estado(P,M,Ho,Ha,NPol,Lad,1))).

%Mueve al policia y a un niño de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(P,M,NHo,Ha,NPol,Lad,0)):-Pol>0,Ho>0,NPol is Pol-1,NHo is Ho-1,not(peligro(estado(P,M,NHo,Ha,NPol,Lad,0))).

%Mueve al policia y a un niño de derecha a izquierda 
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(P,M,NHo,Ha,NPol,Lad,1)):-Pol<1,Ho<2,NNPol is Pol+1,NHo is Ho+1,not(peligro(estado(P,M,NHo,Ha,Pol,Lad,1))).

%Mueve al policia y a una niña de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(P,M,Ho,NHa,NPol,Lad,0)):-Pol>0,Ha>0,NPol is Pol-1,NHa is Ha-1,not(peligro(estado(P,M,Ho,NHa,NPol,Lad,0))).

%mueve al policia y a una niña de derecha a izquierda
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(P,M,Ho,NHa,NPol,Lad,1)):-Pol<1,Ha<2,NPol is Pol+1,NHa is Ha+1,not(peligro(estado(P,M,Ho,NHa,NPol,Lad,1))).

%Mueve al padre de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(NP,M,Ho,Ha,Pol,Lad,0)):-P>0,NP is P-1,not(peligro(estado(NP,M,Ho,Ha,Pol,Lad,0))).

%Mueve al padre de derecha a izquierda
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(NP,M,Ho,Ha,Pol,Lad,1)):-P<1,NP is P+1,not(peligro(estado(NP,M,Ho,Ha,Pol,Lad,1))).

%Mueve a la madre de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(P,NM,Ho,Ha,Pol,Lad,0)):-M>0,NM is M-1,not(peligro(estado(P,NM,Ho,Ha,Pol,Lad,0))).

%Mueve a la madre de derecha a izquierda
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(P,NM,Ho,Ha,Pol,Lad,1)):-M<1,NM is M+1,not(peligro(estado(P,NM,Ho,Ha,Pol,Lad,1))).

%Mueve al padre y a un hijo de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(NP,M,NHo,Ha,Pol,Lad,0)):-P>0,Ho>0,NP is P-1,NHo is Ho-1,not(peligro(estado(NP,M,NHo,Ha,Pol,Lad,0))).

%Mueve al padre y a un hijo de derecha a izquierda
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(NP,M,NHo,Ha,Pol,Lad,1)):-P<1,Ho<2,NP is P+1,NHo is Ho+1,not(peligro(estado(NP,M,NHo,Ha,Pol,Lad,1))).

%Mueve a la madre y a una hija de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(P,NM,Ho,NHa,Pol,Lad,0)):-M>0,Ha>0,NM is M-1,NHa is Ha-1,not(peligro(estado(P,NM,Ho,NHa,Pol,Lad,0))).

%Mueve a la madre y a una hija de derecha a izquierda
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0),estado(P,NM,Ho,NHa,Pol,Lad,1)):-M<1,Ha<2,NM is M+1,NHa is Ha+1,not(peligro(estado(P,NM,Ho,NHa,Pol,Lad,1))).

%Mueve al padre y a la madre de izquierda a derecha
movimiento(estado(P,M,Ho,Ha,Pol,Lad,1),estado(NP,NM,Ho,Ha,Pol,Lad,0)):-P>0,M>0,NP is P-1, NM is M-1,not(peligro(estado(NP,NM,Ho,Ha,Pol,Lad,0))).

%Mueve al padre y a la madre de derecha a izquierda
movimiento(estado(P,M,Ho,Ha,Pol,Lad,0)),estado(NP,NM,Ho,Ha,Pol,Lad,1)):-P<1,M<1,NP is P+1,NM is M+1,not(peligro(estado(NP,NM,Ho,Ha,Pol,Lad,1))).

%Búsqueda recursiva
camino(estado(P1,M1,Ho1,Ha1,Pol1,Lad1,B1),estado(P2,M2,Ho2,Ha2,Pol2,Lad2,B2),Explorados,ListaMovimientos):-
	%Prueba el movimiento
	movimiento(estado(P1,M1,Ho1,Ha1,Pol1,Lad1,B1),estado(P3,M3,Ho3,Ha3,Pol3,Lad3,B3)),
	%que no pertenezca a los estados Explorados
	not(member(estado(P3,M3,Ho3,Ha3,Pol3,Lad3,B3),Explorados)),
	%%llamada recursiva
	camino(estado(P3,M3,Ho3,Ha3,Pol3,Lad3,B3),estado(P2,M2,Ho2,Ha2,Pol2,Lad2,B2),[estado(P3,M3,Ho3,Ha3,Pol3,Lad3,B3)|Explorados],[[estado(P3,M3,Ho3,Ha3,Pol3,Lad3,B3),estado(P1,M1,Ho1,Ha1,Pol1,Lad1,B1)]|ListaMovimientos]).

%Encuentra solucion
camino(estado(NP,NM,NHo,Nha,NPol,NLad,B),estado(NP,NM,NHo,Nha,NPol,NLad,B),_,ListaMovimientos):-
	output(ListaMovimientos).
	%Muestra por pantalla
	output([]) :- nl.
	output([[A,B]|ListaMovimientos]) :- 
	output(ListaMovimientos), 
   	write(B), write(' -> '), write(A), nl.

%soluciona:-camino(estado(1,1,2,2,1,1,1),estado(0,0,0,0,0,0,_),estado(1,1,2,2,1,1,1),_).
soluciona:-camino(estado(1,1,2,2,1,0,1),estado(1,1,2,2,0,0,0),estado(1,1,2,2,1,0,1),_).