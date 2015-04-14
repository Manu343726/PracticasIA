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
    (slot calidad (type NUMBER))
    (slot duraction (type NUMBER))
    (slot destino (type STRING))
    (slot transporte (type STRING))
    (slot compania (type STRING))
    (slot precio (type NUMBER))
    (slot alojamiento (type STRING))
)

(defmodule protegeLoad)

(defrule loadUser "Carga el fact del usuario desde Protege"
    (object (is-a User)(nombre ?n)(edad ?e)(hobby ?h)(presupuesto ?p) (familia ?f) (exotico ?e))
    =>
    (assert (user (nombre ?n)(edad ?e)(hobby ?h)(presupuesto ?p) (familia ?f) (exotico ?e)))
)

(defrule loadTravel "Carga el fact del viaje desde Protege"
    (object (is-a Viaje) (calidad ?c) (duracion ?d) (destino ?de) (transporte ?t) (compania ?co) (precio ?p) (alojamiento ?a))
    =>
    (assert (viaje (calidad ?c) (duracion ?d) (destino ?de) (transporte ?t) (compania ?co) (precio ?p) (alojamiento ?a)))
)
