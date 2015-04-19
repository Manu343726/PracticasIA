;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Este archivo genera las clases y los facts para protegé.
;; De esta manera no hay errores por tipos.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Generación de las clases
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Clase User

(defclass User (is-a :THING)
	(slot season(type INTEGER))
    (slot budget(type INTEGER))
    (slot hobby(type INTEGER))
    (slot age(type INTEGER))
    (slot companion(type INTEGER))
    (slot exotic(type INTEGER))
    (slot continent(type INTEGER))
    (slot languages(type INTEGER))
)

;;Clase travel

(defclass Travel (is-a :THING)
	(slot begins(type INTEGER))
    (slot ends(type INTEGER))
    (slot theme(type INTEGER))
    (slot cost (type INTEGER))
    (slot language(type INTEGER))
    (slot name(type STRING))
    (slot continent (type INTEGER))
    (slot description(type STRING))
)

;;template travel
(mapclass Travel)
(deftemplate travel
	(slot begins(type INTEGER))
    (slot ends(type INTEGER))
    (slot theme(type INTEGER))
    (slot cost (type INTEGER))
    (slot language(type INTEGER))
    (slot name(type STRING))
    (slot continent (type INTEGER))
    (slot description(type STRING))
)

;;Clase recomendación

(defclass Recommendation (is-a :THING)
    (slot name(type STRING))
    (slot description(type STRING))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Declaracion de los viajes para cargarlos en protegé
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts trvl
    ;(travel (begins) (ends) (theme) (language) (company) (name) (description))
	(travel (begins 180)(ends 201)(theme 1)(language 3) (cost 5000) (name "Viaje al Tibet") (continent 1) (description "Un viaje de 21 dias por el Tibet, una experiencia para los mas aventureros"))
	(travel (begins 90)(ends 97)(theme 4)(language 3) (cost 4500) (name "Gastronomia Pekinesa") (continent 1) (description "Siete dias de ensueño en los que pasara por los mejores restaurantes de China, coincidiendo con el mercado de Primavera."))
	(travel (begins 356)(ends 10)(theme 1)(language 0) (cost 8000)(name "La patagonia") (continent 4) (description "La patagonia no es un sitio para cualquiera. Verano es la mejor epoca para visitar a los enormes glaciares que se desprender�n ante tus ojos."))
	(travel (begins 360)(ends 4)(theme 2)(language 4) (cost 1200)(name "El Berlin de los museos") (continent 0) (description "Berlin tiene una cantidad de museos impresionantes, podras visitarlos todos"))
	(travel (begins 360)(ends 4)(theme 3)(language 4) (cost 1000)(name "Roma") (continent 0) (description "Roma es el destino ideal para turistas"))
	(travel (begins 266)(ends 286)(theme 0)(language 1) (cost 1100)(name "Estados unidos en bicicleta") (continent 3) (description "Recorra de costa este a oeste los estados unidos en bicicleta; un viaje duro para los mas osados"))
	(travel (begins 88)(ends 98)(theme 3)(language 2) (cost 4200)(name "Quebeq, la Francia ovlidada") (continent 3) (description "Un viaje por la zona franco-parlante de Canada."))
	(travel (begins 174)(ends 190)(theme 1)(language 1) (cost 4500)(name "Australia: La tierra del peligro") (continent 2) (description "Australia en verano es un sitio inhospito, perfecto para la gente que busca aventuras"))
	(travel (begins 130)(ends 145)(theme 2)(language 5) (cost 3000)(name "La India y la Religion") (continent 1) (description "Un viaje cultural por la India, donde nacion el buddhismo."))
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Modulo de carga
;; Este modulo carta los facts desde Jess a protegé
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmodule loadData)
(defrule loadTravel
	(travel (begins ?be) (ends ?end) (theme ?the) (cost ?cos) (language ?lan) (name ?nam) (continent ?con) (description ?des))
	=>
	(make-instance of Travel (begins ?be) (ends ?end) (theme ?the) (cost ?cos) (language ?lan) (name ?nam) (continent ?con) (description ?des))
)

(deffunction run-system ()
	(reset)
	(focus loadData)
	(run))

	(run-system)