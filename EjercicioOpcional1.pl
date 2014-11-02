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

%Padre con alguna hija en la orilla derecha
peligro(estado(P,M,_,Ha,_,_,_,_)):-P>0,M<1,Ha>0.

%Padre con alguna hija en la orilla izquierda
peligro(estado(P,M,_,Ha,_,_,_,_)):-P<1,M>0,Ha<2.

%Madre con algun hijo en la orilla derecha
peligro(estado(P,M,Ho,_,_,_,_,_)):-M>0,P<1,Ho>0.

%Madre con algun hijo en la orilla derecha
peligro(estado(P,M,Ho,_,_,_,_,_)):-M<1,P>0,Ho<2.

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
movimiento(estado(P,M,Ho,Ha,1,1,1),estado(P,M,Ho,Ha,0,0,0)).

%Mueve al ladrón y al policia del lado derecho al izquierdo.
%Tampoco crea un estado de peligro.
movimiento(estado(P,M,Ho,Ha,0,0,0),estado(P,M,Ho,Ha,1,1,1)).




