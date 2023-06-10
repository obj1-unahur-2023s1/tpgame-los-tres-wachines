import tiposDeObstaculos.*
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
	method id() = "trampa" 
}

class BolaPlasma inherits Trampa{
	override method id() = "bolaPlasma"
}

class CartelMuerte{
	var property image = "ct2.png"
	var property position = game.origin()
	method tipo() = bloqueSolido
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
	method tipo() = puerta
}

class Decoracion{
	var property position
	var property image
	method tipo() = bloqueCaminable
}