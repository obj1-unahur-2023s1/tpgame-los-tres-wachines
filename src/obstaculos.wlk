import tipos.*
import wollok.game.*

class Obstaculo{
	var image
	var position
	method image() = image
	method image(unaImagen){image = unaImagen}
	method position() = position
	method position(unaPos){position = unaPos}
	method estadoInicial()
	method tipo()
	method esDeTipo(unTipo) = self.tipo() == unTipo
}

class ObstaculoNoAtravesable inherits Obstaculo{
	method esAtravesable() = false
}

class ObstaculoAtravesable inherits Obstaculo{
	method esAtravesable() = true
}

class ObstaculoHibrido inherits Obstaculo{
	var esAtravesable = false
	method esAtravesable() = esAtravesable
	method volverAtravesable(){esAtravesable = true}
	method volverNoAtravesable(){esAtravesable = false}
}

class Pared inherits ObstaculoNoAtravesable{
	override method tipo() = bloqueSolido
	override method estadoInicial(){}
}

class Trampa inherits ObstaculoAtravesable(image = "Minijuegos/pincheCerrado.png"){
	override method tipo() = trampa
	method activarTrampa(){
		self.image("Minijuegos/pincheAbierto.png")
		game.schedule(500,{
			self.estadoInicial()
		})
	}
	override method estadoInicial(){
		self.image("Minijuegos/pincheCerrado.png")
	}
}

class CajaMadera inherits ObstaculoAtravesable(image = "Minijuegos/caja.png"){
	override method image() = "Minijuegos/caja.png"
	override method tipo() = caja
	override method estadoInicial(){}
}


class Puerta inherits ObstaculoHibrido(image = "puertaCostadoDer.png"){
	const id
	var estaBloqueada = false
	method id() = id
	override method tipo() = puerta
	method bloquearPuerta(){
		self.volverNoAtravesable()
		estaBloqueada = true
	}
	override method estadoInicial() {
		self.image("puertaCostadoDer.png")
		self.volverNoAtravesable()
		estaBloqueada = false
	}
}


class PuertaDer inherits Puerta{
	override method bloquearPuerta(){
		super()
		self.image("puertaDerReja.png")
	}
	method abrirPuerta() {
		if(!estaBloqueada){
			self.image("puertaCostadoDerAbierta.png")
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
		self.image("puertaIzqReja.png")
	}
	method abrirPuerta() {
		if(!estaBloqueada){
			self.image("puertaCostadoIzqAbierta.png")
			self.volverAtravesable()
		}
	}
	override method estadoInicial() {
		super()
		self.image("puertaCostadoIzq.png")
	}
}


class DecoAtravesable inherits ObstaculoAtravesable{
	override method tipo() = decoracion
	override method estadoInicial(){}
}

class DecoNoAtravesable inherits ObstaculoNoAtravesable{
	override method tipo() = decoracion
	override method estadoInicial(){}
}

class Placa inherits ObstaculoAtravesable(image = "Minijuegos/placaPresion.png"){
	var estaActiva = false
	method estaActiva() = estaActiva
	method activar(){estaActiva = true}
	override method estadoInicial(){estaActiva = false}
	override method tipo() = posaObjeto
}

class PlacaPresion inherits Placa{
	override method activar(){
		super()
		self.image("Minijuegos/placaPresionActiva.png")
	}
	override method estadoInicial(){
		super()
		self.image("Minijuegos/placaPresion.png")
	}
}

class PlacaRompeCabeza inherits Placa{
	const forma
	method initialize(){
		self.image("Minijuegos/placa"+forma+".png")		
	}
	method forma() = forma
	override method estadoInicial(){
		super()
		self.image("Minijuegos/placa"+forma+".png")
	}
	override method activar(){
		super()
		self.image("Minijuegos/placa"+forma+"Activa.png")
	}
}


class Palanca inherits ObstaculoAtravesable(image = "Minijuegos/palanca.png"){
	const id
	var estaActiva = false
	method id() = id
	method estaActiva() = estaActiva
	method activar(){
		self.image("Minijuegos/palancaActiva.png")
		estaActiva = true
	}
	override method estadoInicial(){
		self.image("Minijuegos/palanca.png")
		estaActiva = false
	}
	override method tipo() = palanca
}

class LamparaNivel inherits ObstaculoNoAtravesable(image = "Minijuegos/luzApagada.png"){
	const id
	method id() = id
	method encender(){self.image("Minijuegos/luzPrendida.png")}
	override method tipo() = lampara
	override method estadoInicial(){
		self.image("Minijuegos/luzApagada.png")
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
			self.image("portalActivo.png")
			self.volverAtravesable()
		}
	}
}

class BloqueForma inherits ObstaculoAtravesable{
	const forma
	const posicionInicial = position
	method forma() = forma
	override method tipo() = bloqueForma
	override method estadoInicial(){
		position = posicionInicial
	}
}

class PlacaSimon inherits ObstaculoAtravesable{
	const id
	method id() = id
	override method estadoInicial(){}
	override method tipo() = placaSimon
}


class BotonInicio inherits ObstaculoAtravesable(image = "Carteles/iniciar.png", position = game.at(13,3)){
	method activar(){
		self.image("Carteles/iniciarActivo.png")
	}
	override method estadoInicial(){
		self.image("Carteles/iniciar.png")
	}
	override method tipo() = decoracion
}

class BotonReinicio inherits BotonInicio(image = "Carteles/reiniciar.png", position = game.at(9,3)){
	override method activar(){
		self.image("Carteles/reiniciarActivo.png")
	}
	override method estadoInicial(){
		self.image("Carteles/reiniciar.png")
	}
}

class BotonTerminar inherits BotonInicio(image = "Carteles/terminar.png", position = game.at(17,3)){
	override method activar(){
		self.image("Carteles/terminarActivo.png")
	}
	override method estadoInicial(){
		self.image("Carteles/terminar.png")
	}
}
