frase(Salida) -->
		[A],
		{	name(A, Cadena),
			append(AnadidoCad, AppointCad, Cadena),
			name(Appoint, AppointCad),
			es_appointment(Appoint),
			name(Anadido, AnadidoCad),
			es_anadir(Anadido, Salida)
		}.

% Gramatica

consulta:- 	write('Escribe la frase entre corchetes separando palabras con comas'), nl,
			write('o una lista vacia para parar'), nl,
			read(F),
			trata(F).

trata([]):-write('final').

% Tratamiento final

trata(F):-frase(Salida,F,[]),write(Salida),consulta.

% Tratamiento en caso general

%trata(F):-

% Diccionario

es_appointment(reunion).
es_appointment(cita).

es_anadir(anade, anadida).
es_anadir(pon, puesta).

es_borrar(borra).
es_borrar(quita).

es_consulta(que).
es_consulta(cuanto).

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