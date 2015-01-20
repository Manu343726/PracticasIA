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

%Vierte A en B.
operacion(estado(W,X,Y,Z), estado(NW, X, NY, Z)):- W>0, 