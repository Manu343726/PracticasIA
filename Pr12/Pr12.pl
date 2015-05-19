frase -->  grupo_accion, grupo_quien(N), grupo_tiempo(D,M,H),
{
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

grupo_accion --> es_anadir ,es_appointment.

grupo_quien(N) --> es_prep, [N].

grupo_tiempo(D,M,H) --> [el], [D], [de], [M], [a,las], [H],
{
H>0-1,
H<24,
es_mes(M,Daux),
D>0,
D=<Daux
}.


% Diccionario


es_anadir-->[anade].
es_anadir-->[pon].

es_appointment-->[reunion].
es_appointment-->[cita].

es_prep-->[de].
es_prep-->[con].

es_borrar-->[borra].
es_borrar-->[quita].

es_consulta-->[que].
es_consulta-->[quien].
es_consulta-->[cuando].

%Datos

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