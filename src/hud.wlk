import wollok.game.*
import tipos.*

object visualVida {
	var property image = "corazon.png"
	var property position = game.at(0,game.height()-1)
}
object cantidadVida {
	var property texto
	method position() = game.at(1,game.height()-1)
	method textColor() = "#ffffff"
	method text() = "x" + texto.toString()
	method tipo(){}
	method actualizar(personaje){
		game.removeVisual(self)
		texto = personaje.getVidas()
		game.addVisual(self)
	}
}


object bordeNegro{
	var property image = "bordeNegroPasillo.png"
	method position() = game.origin()
}


class CartelMuerte{
	var property image = "ct2.png"
	var property position = game.origin()
	method tipo(){}
}
