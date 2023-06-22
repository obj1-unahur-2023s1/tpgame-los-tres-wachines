import tipos.*
import wollok.game.*

class ObstaculoNoAtravesable{
	var esAtravesable = false
	method esAtravesable() = esAtravesable
	method estadoInicial(){}
}

class ObstaculoAtravesable{
	method esAtravesable() = true
	method estadoInicial(){}
}

class Pared inherits ObstaculoNoAtravesable{
	var property position
	var property image
	method tipo() = bloqueSolido
}

class Trampa inherits ObstaculoAtravesable{
	var property image = "pincheCerrado.png"
	var property position
	method tipo() = trampa
	method activarTrampa(){
		image = "pincheAbierto.png"
	}
	override method estadoInicial(){
		image = "pincheCerrado.png"
	}
}

class CajaMadera inherits ObstaculoAtravesable{
	var property position
	method image() = "caja.png"
	method tipo() = objetoMovible
}


class Puerta inherits ObstaculoNoAtravesable{
	var property id
	var property position
	var estaBloqueada = false
	var image = "puertaCostadoDer.png"
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method tipo() = puerta
	method bloquearPuerta(){
		esAtravesable = false
		estaBloqueada = true
	}
	override method estadoInicial() {
		image = "puertaCostadoDer.png"
		esAtravesable = false
		estaBloqueada = false
	}
}


class PuertaDer inherits Puerta{
	override method bloquearPuerta(){
		super()
		image = "puertaDerReja.png" 
	}
	method abrirPuerta() {
		if(!estaBloqueada){
			image = "puertaCostadoDerAbierta.png"
			esAtravesable = true
		}
	}
}


class PuertaIzq inherits Puerta{
	method initialize(){
		self.image("puertaCostadoIzq.png")
	}
	override method bloquearPuerta(){
		super()
		image = "puertaIzqReja.png" 
	}
	method abrirPuerta() {
		if(!estaBloqueada){
			image = "puertaCostadoIzqAbierta.png"
			esAtravesable = true
		}
	}
	override method estadoInicial() {
		super()
		image = "puertaCostadoIzq.png"
	}
}


class DecoAtravesable inherits ObstaculoAtravesable{
	var property position
	var property image
	method tipo() = decoracion
}

class PlacaPresion inherits ObstaculoAtravesable{
	var property position
	var property image = "placaPresion.png"
	var estaActiva = false
	method estaActiva() = estaActiva
	method activar(){
		image = "placaPresionActiva.png"
		estaActiva = true
	}
	method desactivar(){
		image = "placaPresion.png"
		estaActiva = false
	}
	method tipo() = placaPresion
}


class Palanca inherits ObstaculoAtravesable{
	var property id
	var property position
	var property image = "palanca.png"
	var estaActiva = false
	method estaActiva() = estaActiva
	method activar(){
		image = "palancaActiva.png"
		estaActiva = true
	}
	method desactivar(){
		image = "palanca.png"
		estaActiva = false
	}
	method tipo() = palanca
}

class LamparaNivel inherits ObstaculoNoAtravesable{
	const id
	var position
	var image = "luzApagada.png"
	method id() = id
	method image() = image
	method image(unaImagen){image = unaImagen}
	method position() = position
	method encender(){image = "luzPrendida.png"}
	method tipo() = lampara
	override method estadoInicial(){
		image = "luzApagada.png"
	}
}


class Portal inherits Puerta{
	method initialize(){
		self.estadoinicial()
	}
	method estadoinicial(){
		self.image("portalApagado.png")
		estaBloqueada = true
	}
	method desbloquearPuerta(){
		self.image("portalParaActivar.png")
		estaBloqueada = false
	}
	method abrirPuerta() {
		if(!estaBloqueada){
			image = "portalActivo.png"
			esAtravesable = true
		}
	}
}


//class Pizarron{
//	
//}
