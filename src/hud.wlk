import wollok.game.*
/*
object visualVida {
	var property image = "corazon.png"
	var property position = game.at(0,game.height()-1)
}
*/

object cantidadVida {
	var texto
	method texto(unTxt) {texto = unTxt}
	method position() = game.at(1,0)  
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
	const image = "marcoEjemplo.png"
	const position = game.at(0,0)
	method image() = image
	method position() = position
}

object objetoInventario{
	var image = "vacio.png"
	method position() = game.at(3,0)
	method image() = image
	method image(unaImagen) {image = unaImagen}
}

object bordeNegro{
	var image = "bordeNegroPasillo.png"
	method position() = game.origin()
	method image() = image
	method image(unaImagen) {image = unaImagen}
}

class Cartel{
	var image 
	const position = game.origin()
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method position() = position
	method tipo(){}
}
