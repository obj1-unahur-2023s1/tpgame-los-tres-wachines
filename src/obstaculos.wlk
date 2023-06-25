import tipos.*
import wollok.game.*

class ObstaculoNoAtravesable{
	method esAtravesable() = false
	method estadoInicial()
}

class ObstaculoAtravesable{
	method esAtravesable() = true
	method estadoInicial()
}

class ObstaculoHibrido{
	var esAtravesable = false
	method esAtravesable() = esAtravesable
	method volverAtravesable(){esAtravesable = true}
	method volverNoAtravesable(){esAtravesable = false}
	method estadoInicial()
}

class Pared inherits ObstaculoNoAtravesable{
	var property position
	var property image
	method tipo() = bloqueSolido
	override method estadoInicial(){}
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
	method tipo() = caja
	override method estadoInicial(){}
}


class Puerta inherits ObstaculoHibrido{
	var property id
	var property position
	var estaBloqueada = false
	var image = "puertaCostadoDer.png"
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method tipo() = puerta
	method bloquearPuerta(){
		self.volverNoAtravesable()
		estaBloqueada = true
	}
	override method estadoInicial() {
		image = "puertaCostadoDer.png"
		self.volverNoAtravesable()
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
			self.volverAtravesable()
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
			self.volverAtravesable()
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
	override method estadoInicial(){}
}

class Placa inherits ObstaculoAtravesable{
	var property position
	var property image = "placaPresion.png"
	method tipo() = posaObjeto
}

class PlacaPresion inherits Placa{
	var estaActiva = false
	method estaActiva() = estaActiva
	method activar(){
		image = "placaPresionActiva.png"
		estaActiva = true
	}
	override method estadoInicial(){
		image = "placaPresion.png"
		estaActiva = false
	}
}

class PlacaRompeCabeza inherits Placa{
	const forma
	method color() = forma
	override method estadoInicial(){}
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
	override method estadoInicial(){
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
		self.estadoInicial()
	}
	override method estadoInicial(){
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
			self.volverAtravesable()
		}
	}
}

class BloqueForma inherits ObstaculoAtravesable{
	var property position
	method image() = "rombo.png"
	method tipo() = bloqueForma
	override method estadoInicial(){}
}

//class Pizarron{
//	
//}
