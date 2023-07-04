import wollok.game.*
import tipos.*
/*
object visualVida {
	var property image = "corazon.png"
	var property position = game.at(0,game.height()-1)
}
*/

object visualVida{
	var image = "HUD/corazon3.png"
	var tick = 0
	
	method position() = game.at(2,0)
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method esAtravesable()=true
	method tipo() = hud
	method esDeTipo(unTipo) = self.tipo() == unTipo
	method animacionPerderVida(){
		game.onTick(30, "animacion", {self.cambiarImagen()})
	}
	method cambiarImagen(){
		if(tick<19){
			image = "HUD/corazonR"+(tick%19)+".png"
			tick++				
		}
	}
	method removerAnimacionPerderVida(cantVidas){
		game.removeTickEvent("animacion")
		if(cantVidas > 0){
			image = "HUD/corazon"+ cantVidas +".png"
			tick = 0						
		}
	}
	
	method actualizarImagenCon(cantVidas){
		image = "HUD/corazon"+ cantVidas +".png"
		tick = 0
	}
	
}

object marco{
	const image = "HUD/marco.png"
	const position = game.at(0,0)
	method image() = image
	method position() = position
	method tipo() = hud
	method esAtravesable()=true
	method esDeTipo(unTipo) = self.tipo() == unTipo
}

object objetoInventario{
	var image = "Minijuegos/vacio.png"
	method position() = game.at(1,0)
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
