import wollok.game.*

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
}


object bordeNegro{
	var property image = "bordeNegroPasillo.png"
	method position() = game.origin()
}