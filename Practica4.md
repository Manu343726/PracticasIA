
Inteligencia Artificial. Práctica 4
===================================

Manuel Sánchez Pérez 51114920-L
Pablo Mac-Veigh García-Lastra 50766233-N 

Descripción general
-------------------

La Práctica consiste en dos clases, `SimplifiedRoadOfSpain.java` y `SpainMapDemo.java`.

La primera tiene definidas las ciudades con sus coordenadas y los links bidiraccionales entre ellas. Dichas coordenadas están especificadas en formato UTM. Dichas coordenadas son relativas a cierto cuadrante, con valores dentro del intervalo [-1,1] dentro de dicho cuadrante. En nuestro caso, las coordenadas de la práctica están especificadas con respecto al cuadrante 30-Norte.  
Nótese que, como respuesta a la pregunta del apartado 3, Cáceres se encuentra fuera de dicho cuadrante, por lo que no podríamos incluir esta ciudad en nuestro mapa directamente. Se podría introducir, pero su posición sería incorrecta.

Ejecución
---------

La siguiente tabla recoge una serie de ejecuciones aleatorias de búsquedas en nuestro mapa utilizando el algoritmo A*:

    +=============+=============+============+==================+=======+
    |    Origen   |   Destino   | Heurística | Nodos expandidos | Coste |
    +=============+=============+============+==================+=======+
    |   Albacete  |     León    |     = 0    |        14        | 654.0 |
    +-------------+-------------+------------+------------------+-------+
    |   Albacete  |     León    |     SLD    |         9        | 654.0 |
    +-------------+-------------+------------+------------------+-------+
    |    Zamora   | Guadalajara |     = 0    |         9        | 343.6 |
    +-------------+-------------+------------+------------------+-------+
    |    Zamora   | Guadalajara |     SLD    |         7        | 343.6 |
    +-------------+-------------+------------+------------------+-------+
    | Ciudad Real |     León    |     = 0    |        14        | 537.4 |
    +-------------+-------------+------------+------------------+-------+
    | Ciudad Real |     León    |     SLD    |         6        | 537.4 |
    +-------------+-------------+------------+------------------+-------+


En general parece que la heurística SLD (Por las siglas en inglés *Straight Line Distance*) reduce considerablemente la exploración del espacio de búsqueda, nótese la diferencia de nodos expandidos entre la heurística cero y SLD.   

Los costes con las diferentes heurísticas son los mismos, lo cual concuerda con el hecho de que A* siempre consigue el camino óptimo independientemente de la heurística utilizada.

Apéndice: Coordenadas en sistema UTM
------------------------------------

Hacen falta las capitales de provincia de Castilla-Leon, Castilla-La Mancha y Madrid en coordenadas UTM (en km).
Cada Provincia será un nodo.

```
Castilla-Leon:
	Ávila : (357.873, 4592.005)
	Burgos : (442.595, 4688.205)
	León : (289.397, 4719.450)
	Palencia : (373.405, 4651.982)
	Salamanca : (275.879, 4538.855)
	Segovia : (406.666, 4533.010)
	Soria : (543.302, 4623.993)
	Valladolid: (356.400, 4612.603)
	Zamora: (270.746, 4598.292)

Castilla-La Mancha:
	Albacete : (598.850, 4316.769)
	Ciudad Real: (419.678, 4315.502)
	Cuenca: (573.554, 4435.926)
	Guadalajara: (486.454, 4497.973)
	Toledo: (412.131, 4413.037)

Madrid:
	Madrid : (440.291, 4474.254)
```

Se considera Madrid como la coordenada (0,0). Entonces la tabla anterior se representa como:

```
Castilla-Leon:
	Ávila:(-82.418, 28.751)
	Burgos:(2.304, 213.951)
	León:(-150.894, 245.196)
	Palencia:(-66.886, 177.728)
	Salamanca:(-164.412, 64.601)
	Segovia:(-33.625, 58.756)
	Soria:(103.011, 149.739)
	Valladolid:(-83,891, 138.349)
	Zamora:(-169.545, 124.038)

Castilla-La Mancha:
	Albacete:(158.559, -157.485)
	Ciudad Real:(-20.613, -158.752)
	Cuenca:(133.263, -38.328)
	Guadalajara:(46.163, 23.719)
	Toledo:(-28.16, -61.217)

Madrid:
	Madrid:(0, 0)
```