(mapclass User)
(deftemplate user
    (slot nombre (type STRING))
    (slot edad (type NUMBER))
    (slot hobby (type STRING))
    (slot presupuesto (type NUMBER))
    (slot familia (type NUMBER))
    (slot exotico (type NUMBER))
)

(mapclass Viaje)
(deftemplate viaje
	(slot alojamiento)
	(slot calidad)
	(slot destino)
	(slot duracion)
	(slot precio)
	(slot transporte)
	(slot viaje_ofrecido_por)
)

(defmodule protegeLoad)

(defrule loadUser "Carga el fact del usuario desde Protege"
    (object (is-a User)(Nombre ?n)(Edad ?e)(Hobby ?h)(Presupuesto ?p) (Familia ?f) (Exotico ?e))
    =>
    (assert (user (nombre ?n)(edad ?e)(hobby ?h)(presupuesto ?p) (familia ?f) (exotico ?e)))
)

(defrule loadTravel "Carga el fact del viaje desde Protege"
    (object (is-a Viaje) (alojamiento ?a) (calidad ?c) (destino ?d) (duracion ?dur) (precio ?p) (transporte ?t) (viaje_ofrecido_por ?v))
    =>
    (assert (viaje  (alojamiento ?a) (calidad ?c) (destino ?d) (duracion ?dur) (precio ?p) (transporte ?t) (viaje_ofrecido_por ?v)))
)
