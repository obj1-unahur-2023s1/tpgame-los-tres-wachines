import tipos.*
import wollok.game.*

class Pared{
	var property position
	var property image
	method tipo() = bloqueSolido
}

class Trampa {
	var property image = "pincheCerrado.png"
	var property position
	method tipo() = objetoPeligroso
}

class CajaMadera{
	var property position
	method image() = "caja2.png"
	method tipo() = objetoMovible 
}

class Puerta{
	var property id
	var property position
	var property image
	var estaCerrada = true
	method tipo() = puerta
	method estaCerrada() = estaCerrada
	method abrirPuerta() {estaCerrada = !estaCerrada}
}

class Decoracion{
	var property position
	var property image
	method tipo() = bloqueCaminable
}