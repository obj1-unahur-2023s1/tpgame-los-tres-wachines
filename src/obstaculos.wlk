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
	method image() = "caja2.png"
	method tipo() = objetoMovible
}

class PuertaDer inherits ObstaculoNoAtravesable{
	var property id
	var property position
	var image = "puertaCostadoDer.png"
	method image() = image
	method image(unaImagen) {image = unaImagen}
	method tipo() = puerta
	method abrirPuerta() {
		image = "puertaCostadoDerAbierta.png"
		esAtravesable = true
	}
	override method estadoInicial() {
		image = "puertaCostadoDer.png"
		esAtravesable = false
	}
}

class PuertaIzq inherits PuertaDer{
	method initialize(){
		self.image("puertaCostadoIzq.png")
	}
	override method abrirPuerta() {
		super()
		image = "puertaCostadoIzqAbierta.png"
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

class PlacaPresion inherits ObstaculoAtravesable{}
class FragmentoDeLLave inherits ObstaculoAtravesable{}
class Palanca inherits ObstaculoAtravesable{}
class DecoNoAtravesable inherits ObstaculoNoAtravesable{}
object puertaFinal inherits ObstaculoNoAtravesable{}

class Pizarron{
	
}

