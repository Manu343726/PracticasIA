frase(Salida) -->  grupo_anadir, grupo_quien(N), grupo_tiempo(D,M,H),
{
	assert(cita(D,M,H,1,N)),

	string_concat('Reunion programada con ', N, Aux1),
	string_concat(Aux1, ' el dia ', Aux2),
	string_concat(Aux2, D, Aux3),
	string_concat(Aux3, ' de ', Aux4),
	string_concat(Aux4, M, Aux5),
	string_concat(Aux5, ' a las ', Aux6),
	string_concat(Aux6, H, Aux7),
	string_concat(Aux7, '.', Salida)

}.

frase(Salida) -->  grupo_borrar, grupo_quien(N),
{
	retract(cita(_,_,_,_,N)),
	string_concat('Su reunion con ', N, Aux1),
	string_concat(Aux1, ' ha sido cancelada.', Salida)
}.

frase(Salida) --> grupo_borrar, grupo_tiempo(D,M,H),
{
	retract(cita(D,M,H,_,_)),

	string_concat('Su cita del ', D, Aux1),
	string_concat(Aux1, '/', Aux2),
	string_concat(Aux2, M, Aux3),
	string_concat(Aux3, ' a las ', Aux4),
	string_concat(Aux4, H, Aux5),
	string_concat(Aux5, ' ha sido cancelada', Salida)
}.

frase(Salida) --> grupo_borrar, [de], grupo_tiempo(D,M,H),
{
	retract(cita(D,M,H,_,_)),

	string_concat('Su cita del ', D, Aux1),
	string_concat(Aux1, '/', Aux2),
	string_concat(Aux2, M, Aux3),
	string_concat(Aux3, ' a las ', Aux4),
	string_concat(Aux4, H, Aux5),
	string_concat(Aux5, ' ha sido cancelada', Salida)
}.

frase(Salida) --> grupo_querry_tiempo, grupo_tiempo(D,M,H),
{
escribe(ListaCitas),
setof((D,M,J,Du,P), cita(D,M,_,_,_), ListaCitas)
}.

frase(Salida) --> grupo_querry_persona, grupo_quien(N),
{
%setof(cita, cita(_,_,_,_,N), Salida)
}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% GRAMATICAS %%%%%%%%%%%

consulta:- write('Escribe frase entre corchetes separando palabras con comas '), nl,
write('o lista vacia para parar '), nl,
read(F),
trata(F).

trata([]):- write('final').
trata(F):- frase(Salida, F, []), write(Salida),nl, consulta.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% GRUPOS SINTACTICOS %%%%%%

%%%%% Grupo para preguntar por las citas futuras %%%%%

grupo_querry_tiempo--> es_consulta_tiempo, [tengo].
grupo_querry_tiempo--> es_consulta_tiempo, es_appointments, [tengo].

%%%%% Grupo para preguntar por las citas con alguien %%%%%

grupo_querry_persona--> es_consulta_persona, [tengo], es_consulta_persona_det,
es_appointment.

%%%%%% Grupo para añadir una cita

grupo_anadir --> es_anadir ,es_appointment.


%%%%%% Grupo para borrar una cita

grupo_borrar --> es_borrar, es_appointment.


%%%%%% Grupo para saber de que cita hablamos.

grupo_quien(N) --> es_prep, [N].


%%%%%% Grupo temporal para dar una fecha específica.

grupo_tiempo(D,M,H) --> es_prep_temp, [D], [de], [M], [a,las], [H],
{
H>0-1,
H<24,
es_mes(M,Daux),
D>0,
D=<Daux
}.


%%%%%% Grupo temporal para hoy.

grupo_tiempo(D,M,H) --> [hoy,a,las], [H],
{
hoy(D,M)
}.


%%%%%% Grupos temporales para mañana.

grupo_tiempo(D,M,H) --> [manana,a,las], [H],
{
hoy(A,M),
D is A + 1
}.

grupo_tiempo(D,M,H) --> [manana],
{
hoy(A,M),
D is A + 1
}.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% DICCIONARIO %%%%%%%%%%

es_anadir-->[anade,una].
es_anadir-->[pon,una].

es_appointment-->[reunion].
es_appointment-->[cita].

es_appointments-->[reuniones].
es_appointments-->[citas].

es_prep_temp-->[el].
es_prep_temp-->[del].

es_prep-->[de].
es_prep-->[con].

es_borrar-->[borra,la].
es_borrar-->[quita,la].

es_consulta_tiempo-->[que].

es_consulta_persona-->[cuando].

es_consulta_persona_det-->[una].
es_consulta_persona_det-->[la].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DATOS %%%%%%%%%%%%%
:- dynamic cita/5.


hoy(19,5).

es_mes(enero, 31).
es_mes(febrero, 28).
es_mes(marzo, 31).
es_mes(abril, 30).
es_mes(mayo, 31).
es_mes(junio, 30).
es_mes(julio, 31).
es_mes(agosto, 31).
es_mes(septiembre, 30).
es_mes(octubre, 31).
es_mes(noviembre, 30).
es_mes(diciembre, 31).

escribe([]):- write('Fin').

escribe([(D,M,H,D,P)|Resto]):-
write([cita,el,dia,D,de,M,a,las,H,durante,D,con,P]),
nl.