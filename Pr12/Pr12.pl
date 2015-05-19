frase -->  grupo_accion, grupo_quien(N), grupo_tiempo(D,M,H).

grupo_accion --> es_anadir ,es_appointment.

grupo_quien(N) --> es_prep, [N].

grupo_tiempo(D,M,H) --> es_det, [D], es_prep, [M], es_hora, [H].


% Diccionario


es_anadir-->[anade].
es_anadir-->[pon].

es_appointment-->[reunion].
es_appointment-->[cita].

es_prep-->[de].
es_prep-->[con].

es_det-->[el].

es_hora-->[a,las].

es_borrar-->[borra].
es_borrar-->[quita].

es_consulta-->[que].
es_consulta-->[quien].
es_consulta-->[cuando].

%Datos

es_mes(enero, 1, 31).
es_mes(febrero, 2, 28).
es_mes(marzo, 3, 31).
es_mes(abril, 4, 30).
es_mes(mayo, 5, 31).
es_mes(junio, 6, 30).
es_mes(julio, 7, 31).
es_mes(agosto, 8, 31).
es_mes(septiembre, 9, 30).
es_mes(octubre, 10, 31).
es_mes(noviembre, 11, 30).
es_mes(diciembre, 12, 31).