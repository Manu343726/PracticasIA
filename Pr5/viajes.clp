
;Definition del template del usuario
(deftemplate user
    (slot season(type number)); Época del año en la que el usuario quiere viajar (ENUMERADO)
    (slot budget(type number)); Presupuesto
    (slot hobby(type number)); Afición (ENUMERADO). TODO: multislot varias aficiones
    (slot age(type number)); Edad
    (slot companion(type number)); Acompañantes (ENUMERADO)
    (slot exotic(type number)); Busca un viaje exótico? (TRUE:1, FALSE:0)
    (slot languages(type number)); Idioma (ENUMERADO)
)

;Deficición template viaje
(deftemplate travel
	(slot begins(type number)); Día que empieza el viaje (Índice 0-364 representando un día del año)
    (slot ends(type number)); Día que termina el viaje (Índice 0-364 representando un día del año)
    (slot theme(type number)); Temática del viaje (Deporte, turismo, aventura, etc) (ENUMERADO)
    ;TODO ofertas especiales
    (slot language(type number)); Idioma del sitio de destino (Ver languages en user) TODO: multislot varios idiomas
    (slot company(type STRING)); Compañía
    (slot name(type STRING)); Título
    (slot description(type STRING)); Descripción del viaje     
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enumeraciones
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Season
;;
;; Rangos estacionales basados en http://www.almanac.com/content/first-day-seasons
;;
;; 0: primavera (90 días 82 - 172)
;; 1: verano    (90 días 173 - 263)
;; 2: otoño     (90 días 264 - 354)
;; 3: invierno  (91 días 355 - 81)

;; hobby 
;;
;;
