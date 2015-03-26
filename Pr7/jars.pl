%Pablo Mac-Veigh
%Manuel Sanchez

%Representación de los estados del problema de las jarras


%Hemos decidido definir el estado como estado(contenidoJarraA,maxJarraA,contenidoJarraB,maxJarraB)
%De esta forma el problema se puede resolver para cualquier maximo de jarras y no solo 3 y 4.
%Por lo tanto el estado inicial sería : estado(0,3,0,4).
%Y por tanto el estado objetivo sería : estado(_,3,2,4).

%Operaciones posibles

%Llena la jarra A.
operacion(estado(W,X,Y,Z),estado(NW,X,Y,Z)):-NW is X.

%Llena la jarra B.
operacion(estado(W,X,Y,Z),estado(W,X,NY,Z)):-NY is Z.

%Vacía la jarra A.
operacion(estado(W,X,Y,Z),estado(NW,X,Y,Z)):-NW is W-W.

%Vacía la jarra B.
operacion(estado(W,X,Y,Z),estado(W,X,NY,Z)):-NY is Y-Y.

%Vierte A en B: Caso Vol A >= (Max B - Vol B)
operacion(estado(W,X,Y,Z), estado(NW, X, NY, Z)):- AUX is Z-Y, W >= AUX, NY is Y + AUX, NW is W - AUX.

%Vierte A en B: Caso Vol A < (Max B - Vol B)
operacion(estado(W,X,Y,Z), estado(NW,X,NY,Z)):- AUX is Z-Y, W < AUX, NY is Y + W, NW is 0.

%Vierte B en A: Caso Vol B >= (Max A - Vol A)
operacion(estado(W,X,Y,Z), estado(NW,X,NY,Z)):- AUX is X-W, Y >= AUX, NW is W + AUX, NY is Y - AUX.

%Vierte B en A: Caso Vol B < (Max A - Vola A)
operacion(estado(W,X,Y,Z), estado(NW,X,NY,Z)):- AUX is X-W, Y < AUX, NW is W + Y, NY is 0.

camino(estado(W1,X1,Y1,Z1),estado(W2,X2,Y2,Z2), Explorados, ListaMovimientos):-
	operacion(estado(W1,X1,Y1,Z1),estado(W3,X3,Y3,Z3)),
	not(member(estado(W3,X3,Y3,Z3),Explorados)),
	camino(estado(W3,X3,Y3,Z3),estado(W2,X2,Y2,Z2),[estado(W3,X3,Y3,Z3)|Explorados],[[estado(W3,X3,Y3,Z3),estado(W1,X1,Y1,Z1)]|ListaMovimientos]).

camino(estado(W,X,Y,Z),estado(W,X,Y,Z),_,ListaMovimientos):-
	output(ListaMovimientos).
	output([]) :- nl.
	output([[A,B]|ListaMovimientos]) :- 
	output(ListaMovimientos), 
   	write(B), write(' -> '), write(A), nl.

soluciona:-camino(estado(0,3,0,4),estado(_,3,2,4),estado(0,3,0,4),_).