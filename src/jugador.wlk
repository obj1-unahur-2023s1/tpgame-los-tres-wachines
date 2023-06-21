import wollok.game.*
import obstaculos.*
import tipos.*
import hud.*

object alex {
	var property position = game.center()
	var property movimientoPermitido = true
	var property image = "playerDer.png"
	var posicionAnterior = position
	var property vistaActual = "Abajo"
	var vistaAnterior = "Abajo"
	var objetoEncima = null
	var vidas = 3
	
	// --- MOVIMIENTO ---
	
	method moverArriba(){
		if(movimientoPermitido){
			vistaActual = "Arriba"
			self.visualPersonaje(false)
			if(self.objetoAdelanteEsAtravesable() and vistaAnterior == vistaActual and self.position().y() < game.height()-2){
				posicionAnterior = position
				position = position.up(1)
			}
			vistaAnterior = vistaActual
		}
	}
	method moverDerecha(){
		if(movimientoPermitido){
			vistaActual = "Der"
			self.visualPersonaje(false)
			if(self.objetoAdelanteEsAtravesable() and vistaAnterior == vistaActual and self.position().x() < game.width()-2){
				posicionAnterior = position
				position = position.right(1)
			}
			vistaAnterior = vistaActual	
		}
	}
	method moverIzquierda(){
		if(movimientoPermitido){
			vistaActual = "Izq"
			self.visualPersonaje(false)
			if(self.objetoAdelanteEsAtravesable() and vistaAnterior == vistaActual and self.position().x() > 1){
				posicionAnterior = position
				position = position.left(1)
			}
			vistaAnterior = vistaActual
		}
	}
	method moverAbajo(){
		if(movimientoPermitido){
			vistaActual = "Abajo"
			self.visualPersonaje(false)
			if(self.objetoAdelanteEsAtravesable() and vistaAnterior == vistaActual and self.position().y() > 1){
				posicionAnterior = position
				position = position.down(1)
			}
			vistaAnterior = vistaActual
		}	
	}
	
	method obtenerObjetosAdelante(){
		var sumaX = 0
		var sumaY = 0
		if(vistaActual == "Der"){
			sumaX = 1			
		}else if(vistaActual == "Izq"){
			sumaX = -1
		}else if(vistaActual == "Arriba"){
			sumaY = 1
		}else{
			sumaY = -1
		}
		return game.getObjectsIn(game.at(position.x()+sumaX, position.y()+sumaY))
	}
	
	method hayObstaculo_Adelante(tipo) = self.obtenerObjetosAdelante().any({o => o.tipo() == tipo})
	
	method objetoAdelanteEsAtravesable() {
		const objetosAdelante = self.obtenerObjetosAdelante()
		return objetosAdelante.any({o => o.esAtravesable()}) or objetosAdelante.isEmpty()
	}
	
	// --- VIDAS ---

	method getVidas() = vidas
	method setVidas(cantVidas) {vidas = cantVidas}
	method sumarUnaVida() {vidas = 6.min(vidas+1)}
	method recibirDanio() {
		self.visualPersonaje(true)
		position = posicionAnterior
		vidas = 0.max(vidas-1)
	}

	// --- IMAGEN ---
	
	method visualPersonaje(recibeDanio){
		var final = ".png"
		if(self.tieneLasManosOcupadas()){
			final = "Caja.png"		
			if(recibeDanio){
				final = "DañoConCaja.png"
			}
		} else {
			if(recibeDanio){
				final = "Daño.png"
			}
		}
		image = "player"+vistaActual+final
	}
	
	// --- COLISION ---
	
	method colisionCon_DeTipo_(objeto,tipo) = objeto.tipo() == tipo
	method tipo() = personaje
	method tieneLasManosOcupadas() = objetoEncima != null
	method objetoEnManos() = objetoEncima
	method agarrarObjeto(unObjeto){objetoEncima = unObjeto}
	
}
