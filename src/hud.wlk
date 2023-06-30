import wollok.game.*
import tipos.*
/*
object visualVida {
	var property image = "corazon.png"
	var property position = game.at(0,game.height()-1)
}
*/

object marco{
	var cantVidas = 3
	var image = "marco3.png"
	const position = game.at(0,0)
	method image() = image
	method position() = position
	method tipo() = hud
	method esAtravesable()=true
	method esDeTipo(unTipo) = self.tipo() == unTipo
	method actualizarVidas(vidas){
		if(vidas < cantVidas){
			game.schedule(200,{
				image = "marco0.png"
			})
			game.schedule(500,{			
				image = "marco"+vidas+".png"
			})
			cantVidas--			
		}else{
			game.schedule(200,{
				image = "marco"+vidas+".png"
			})
			cantVidas++
		}
	}
}

object objetoInventario{
	var image = "vacio.png"
	method position() = game.at(3,0)
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method esAtravesable()=true
	method tipo() = hud
	method esDeTipo(unTipo) = self.tipo() == unTipo
}

object bordeNegro{
	var image = "bordeNegroPasillo.png"
	method position() = game.origin()
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method tipo() = hud
	method esAtravesable()=true
	method esDeTipo(unTipo) = self.tipo() == unTipo
}

class Cartel{
	var image 
	const position = game.origin()
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method position() = position
	method tipo() = hud
	method esAtravesable()=true
	method esDeTipo(unTipo) = self.tipo() == unTipo
}
