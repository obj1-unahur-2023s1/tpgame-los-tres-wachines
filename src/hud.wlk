import wollok.game.*
import tipos.*

object visualVida{
	var image = "HUD/corazon3.png"
	var tick = 0
	
	method position() = game.at(2,0)
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method esAtravesable()=true
	method tipo() = hud
	method esDeTipo(unTipo) = self.tipo() == unTipo
	method animacionVidaDe(ganarOPerder){
		game.onTick(30, "animacionVida", {self.secuenciaDeImagenesDe(ganarOPerder)})
	}
	method removerAnimacionVida(){game.removeTickEvent("animacionVida"); tick = 0}
	method secuenciaDeImagenesDe(ganarOPerder){
		if(tick<19) image = "HUD/corazon"+ganarOPerder+(tick%19)+".png"; tick++ 
	}
	method actualizarImagenCon(cantVidas){ if(cantVidas > 0) image = "HUD/corazon"+ cantVidas +".png" }
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
	method estadoInicial() {self.image("Minijuegos/vacio.png")}
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

class CartelInicio inherits Cartel{
	var nroImagen = 0
	method imagenSiguiente(){
		nroImagen = 5.min(nroImagen + 1)
		self.image("Carteles/cartelIntro"+nroImagen+".png")
	}
	method imagenAnterior(){
		nroImagen = 0.max(nroImagen - 1)
		self.image("Carteles/cartelIntro"+nroImagen+".png")
	}
}
