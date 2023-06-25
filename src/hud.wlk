import wollok.game.*
/*
object visualVida {
	var property image = "corazon.png"
	var property position = game.at(0,game.height()-1)
}
*/

object cantidadVida {
	var property texto
	method position() = game.at(1,0)  //original ---> method position() = game.at(1,game.height()-1)
	method textColor() = "#ffffff"
	method text() = "x" + texto.toString()
	method tipo(){}
	method actualizar(unPersonaje){
		game.removeVisual(self)
		texto = unPersonaje.getVidas()
		game.addVisual(self)
	}
}

object marco{
	var property image = "marcoEjemplo.png"
	var property position = game.at(0,0)
}

object objetoInventario{
	var property image = "formaDiamante.png"
	method position() = game.at(3,0)
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
