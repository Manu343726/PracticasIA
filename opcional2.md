
Inteligencia Artificial, ejercicio opcional 2
=============================================

Manuel Sánchez Pérez  
Pablo Mac-Veigh García-Lastra

El espacio de estados: Descripción y representación
---------------------------------------------------

El problema consta de un tablero con siete posiciones, junto con tres fichas blancas y tres fichas negras.  
Para su representación hemos optado por representar directamente el conjunto de casillas del tablero, donde cada casilla puede tener tres estados *vacío*, *blanco*, o *negro*.

```
estado = {"vacio", "blanco", "negro"}
tablero = estado[7]
```

Utilizando esta representación, la configuración inicial sería la siguiente:

```
begin = {"negro", "negro", "negro", "vacío", "blanco", "blanco", "blanco"}
```

y la configuración objetivo sería cualquiera en la que todas las celdas blancas aparezcan primero, de izquierda a derecha. Por ejemplo:

```
end = {"blanco", "vacio", "blanco", "blanco", "negro", "negro", "negro"}
```

### Movimientos y ramificación

Siguiendo las reglas del problema, los únicos movimientos posibles son los siguientes:

 - Mover una ficha a la derecha o a la izquierda una posición.
 - Saltar por encima de una o dos fichas.

Dado que para poder mover una ficha debe existir un hueco a donde moverla, es más fácil representar dichos movimientos con respecto al único espacio existente en el tablero: La celda marcada como *vacío* en ese momento.  
Suponiendo que el vacío está en la posición i-ésima (Contando de izquierda a derecha, empezando en cero) del tablero, los movimientos anteriormente mencionados se corresponden con:

 1. **Mover ficha a la derecha**: `swap(tablero[i],tablero[i-1])`
 2. **Mover ficha a la izquierda**: `swap(tablero[i],tablero[i+1])`
 3. **Saltar una posición a la derecha**: `swap(tablero[i],tablero[i-2])`
 4. **Saltar una posición a la izquierda**: `swap(tablero[i],tablero[i+2])`
 5. **Saltar dos posiciones a la derecha**: `swap(tablero[i],tablero[i-3])`
 6. **Saltar dos posiciones a la izquierda**: `swap(tablero[i],tablero[i+3])`

Por supuesto estos movimientos serán válidos si y solo sí están dentro del rango del tablero:

 1. **Mover ficha a la derecha**: válido si `i > 0`
 2. **Mover ficha a la izquierda**: válido si `i < 6`
 3. **Saltar una posición a la derecha**: válido si `i > 1`
 4. **Saltar una posición a la izquierda**: válido si `i < 5`
 5. **Saltar dos posiciones a la derecha**: válido si `i > 2`
 6. **Saltar dos posiciones a la izquierda**: válido si `i < 4`

Como puede verse por las condiciones, **el factor de ramificación oscila entre 3 y 6**.

### Ciclos

Supongamos el siguiente estado:

```
Sx = {"blanco", "negro", "vacío", "blanco", "blanco", "negro", "negro"}
```

Es fácil entrar en un bucle infinito moviendo la ficha negra a izquierda y derecha una y otra vez:

```
Sx+1 = {"blanco", "negro", "vacío", "blanco", "blanco", "negro", "negro"}
Sx+2 = {"blanco", "vacío", "negro", "blanco", "blanco", "negro", "negro"}
Sx+3 = {"blanco", "negro", "vacío", "blanco", "blanco", "negro", "negro"}
...
Sx+(2k)   = {"blanco", "vacío", "negro", "blanco", "blanco", "negro", "negro"}
Sx+(2k+1) = {"blanco", "negro", "vacío", "blanco", "blanco", "negro", "negro"}
```

Una posible solución sería mantener un registro con los estados ya visitados para no repetirlos, de manera similar a algunos algoritmos de búsqueda como A*.

Heurística
----------

Este es el conjunto de estados objetivo, donde `v` representa *vacío*, `b` representa *blanco*, y `n` representa negro: 

```
v b b b n n n
b v b b n n n 
b b v b n n n
b b b v n n n
b b b n v n n
b b b n n v n
b b b n n n v 
```

Una posible heurística sería contar el número de fichas negras a la derecha de la ficha blanca más a la derecha. Encontrar la ficha blanca más a la derecha tiene un coste O(n) (Podría mantenerse un registro de donde está, obteniendo un coste O(1)).

Dicha heurística mide la distancia exacta al estado objetivo, con lo que debería comportarse bien en los diferentes métodos de búsqueda.





