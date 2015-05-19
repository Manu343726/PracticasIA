frase -->  grupo_anadir, grupo_quien(N), grupo_tiempo(D,M,H),
{
	assert(cita(D,M,H,_,N)),
	write('Reunion programada con '),
	write(N),
	write(' el dia '),
	write(D),
	write(' de '),
	write(M),
	write(' a las '),
	write(H),
	write('.')
}.

frase -->  grupo_borrar, grupo_quien(N),
{
	retract(cita(_,_,_,_,N)),
	write('Su reunion con '),
	write(N),
	write(' ha sido cancelada.')
}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% GRUPOS SINTACTICOS %%%%%%


%%%%%% Grupo para añadir una cita

grupo_anadir --> es_anadir ,es_appointment.


%%%%%% Grupo para borrar una cita

grupo_borrar --> es_borrar, es_appointment.


%%%%%% Grupo para saber de que cita hablamos.

grupo_quien(N) --> es_prep, [N].


%%%%%% Grupo temporal para dar una fecha específica.

grupo_tiempo(D,M,H) --> [el], [D], [de], [M], [a,las], [H],
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


%%%%%% Grupo temporal para mañana.

grupo_tiempo(D,M,H) --> [manana,a,las], [H],
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

es_prep-->[de].
es_prep-->[con].

es_borrar-->[borra,la].
es_borrar-->[quita,la].

es_consulta-->[que].
es_consulta-->[quien].
es_consulta-->[cuando].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DATOS %%%%%%%%%%%%%

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