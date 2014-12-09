(deffacts inicio
    (dd juan maria rosa m)
    (dd juan maria luis h)
    (dd jose laura pilar m)
    (dd luis pilar miguel h)
    (dd miguel isabel jaime h)
    (dd pedro rosa pablo h)
    (dd pedro rosa begoña m))

;father definition
(defrule padre
    (dd ?x ? ?y ?) ;x is y's father
    =>
    (assert (padre ?x ?y)))

;mother definition
(defrule madre
    (dd ? ?x ?y ?) ;x is y's mother
    =>
    (assert (madre ?x ?y)))

;son definition
(defrule hijo1
	(dd ?y ? ?x h) ;x (father) is y's male son
	=>
    (assert (hijo ?x ?y)))

(defrule hijo2
	(dd ? ?y ?x h);x (mother) is y's male son
	=>
    (assert (hijo ?x ?y)))

;daugter definition
(defrule hija1
	(dd ?y ? ?x m);x (father) is y's female son
	=>
    (assert (hija ?x ?y)))

(defrule hija2
	(dd ? ?y ?x m);x (mother) is y's female son
	=>
    (assert (hija ?x ?y)))

;brother definition
(defrule hermano1
    (padre ?x ?y); x is y's father
    (padre ?x ?z); x is z's father
    (dd ? ? ?y h); y is a male
    (test (neq ?z ?y)) ;z is not y
    =>
    (assert (hermano ?y ?z)))

(defrule hermano2
    (madre ?x ?y); x is y's mother
    (madre ?x ?z); x is z's mother
    (dd ? ? ?y h); y is a male
    (test (neq ?z ?y)); z is not y
    =>
    (assert (hermano ?y ?z)))

;sister definition
(defrule hermana1
    (padre ?x ?y); x is y's father
    (padre ?x ?z); x is z's father
    (dd ? ? ?y m); x is a female
    (test (neq ?z ?y)); z is not y
    =>
    (assert (hermana ?y ?z)))

(defrule hermana2
    (madre ?x ?y); x is y's mother
    (madre ?x ?z); y is z's mother
    (dd ? ? ?y m); y is a female
    (test (neq ?z ?y)); z is not y
    =>
    (assert (hermana ?y ?z)))

;grandfather definition
(defrule abuelo1
    (padre ?x ?y); x is y's father
    (padre ?y ?z); y is z's father
    =>
    (assert (abuelo ?x ?z))); x is z's grandfather

(defrule abuelo2
    (padre ?x ?y); x is y's father
    (madre ?y ?z); y is z's mother
    =>
    (assert (abuelo ?x ?z)));x is z's grandfather

;grandmother definition
(defrule abuela1
    (madre ?x ?y);x is y's mother
    (madre ?y ?z);y is z's mother
    =>
    (assert (abuela ?x ?z))); x is z's grandmother

(defrule abuela2
    (madre ?x ?y);x is y's mother
    (padre ?y ?z);y is z's father
    =>
    (assert (abuela ?x ?z)));x is z's grandmother

;cousin definition (male)
(defrule primo1
    (padre ?x ?y);x is y's father
    (hermano ?x ?z);x is z's brother
	(hijo ?v ?z);v is z's son
    =>
    (assert (primo ?y ?v)));y is v's cousin

(defrule primo2
    (padre ?x ?y);x is y's father
    (hermana ?x ?z);x is z's sister
	(hijo ?v ?z);v is z's son
    =>
    (assert (primo ?y ?v))); y is v's cousin.

(defrule primo3
    (madre ?x ?y);x is y's mother
    (hermano ?x ?z);x is z's brother
	(hijo ?v ?z);v is z's son
    =>
    (assert (primo ?y ?v)));y is v's cousin

(defrule primo4
    (madre ?x ?y);x is y's mother
    (hermana ?x ?z);x is z's sister
	(hijo ?v ?z);v is z's son
    =>
    (assert (primo ?y ?v)));y is v's cousin

;cousin definition (female)
(defrule prima1
    (madre ?x ?y);y is y's mother
    (hermana ?x ?z);x is z's sister
	(hija ?v ?z);v is z's daughter
    =>
    (assert (prima ?y ?v)));y is v's cousin

(defrule prima2
    (madre ?x ?y);x is y's mother
    (hermano ?x ?z);x is z's brother
	(hija ?v ?z);v is z's daughter
    =>
    (assert (prima ?y ?v)));y is v's cousin

(defrule prima3
    (padre ?x ?y);x is y's fater
    (hermano ?x ?z);x is z's brother
	(hija ?v ?z);v is z's daughter
    =>
    (assert (prima ?y ?v)));y is v's cousin

(defrule prima4
    (padre ?x ?y);x is y's fater
    (hermana ?x ?z);x is z's sister
	(hija ?v ?z);v is z's daughter
    =>
    (assert (prima ?y ?v)));y is v's cousin

;ascendant definition
(defrule ascendiente1 ;recrusive call (transitive propriety)
    (ascendiente ?x ?y);x is y's ascendant
    (ascendiente ?y ?z);y is z's ascendant
    =>
    (assert (ascendiente ?x ?z)));x is z's ascendant

(defrule ascendiente2
    (padre ?x ?y);x is y's father
    =>
    (assert (ascendiente ?y ?x)));y is x's ascendant

(defrule ascendiente3
    (madre ?x ?y);x is y's mother
    =>
    (assert (ascendiente ?y ?x)));y is x's ascendant

(reset)
(run)
(facts)