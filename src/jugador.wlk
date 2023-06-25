import wollok.game.*
import obstaculos.*
import tipos.*
import hud.*

object alex {
	var property position = game.center()
	var movimientoPermitido = true
	var image = "playerDer.png"
	var posicionAnterior = position
	var property vistaActual = "Abajo"
	var vistaAnterior = "Abajo"
	var objetoEncima = null
	var vidas = 3
	
	// --- MOVIMIENTO ---
	
	method moverArriba(){
		if(movimientoPermitido){
			vistaActual = "Arriba"
			self.actualizarVisual()
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
			self.actualizarVisual()
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
			self.actualizarVisual()
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
			self.actualizarVisual()
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
	
	method bloquearMovimiento() {movimientoPermitido = false}
	method permitirMovimiento() {movimientoPermitido = true}
	method movimientoPermitido() = movimientoPermitido
	
	// --- VIDAS ---

	method getVidas() = vidas
	method setVidas(cantVidas) {vidas = cantVidas}
	method sumarUnaVida() {vidas = 6.min(vidas+1)}
	method recibirDanio() {
		self.bloquearMovimiento()
		vidas = 0.max(vidas-1)
		game.schedule(200, {
			self.actualizarVisualConDanio()
			position = posicionAnterior
		})
		game.schedule(500, {
			self.actualizarVisual()
		})
		game.schedule(700, {
			self.permitirMovimiento()
		})
	}

	// --- IMAGEN ---
	
	method actualizarVisual(){
		if(self.tieneLasManosOcupadas()){	
			image = "player"+vistaActual+"Caja.png"
		}else {
			image = "player"+vistaActual+".png"
		}
	}
	
	method actualizarVisualConDanio(){
		if(self.tieneLasManosOcupadas()){	
			image = "player"+vistaActual+"DañoConCaja.png"
		}else {
			image = "player"+vistaActual+"Daño.png"
		}
	}
	
	method image() = image
	
	
	// --- COLISION ---
	
	method colisionCon_DeTipo_(objeto,tipo) = objeto.tipo() == tipo
	method tipo() = personaje
	method tieneLasManosOcupadas() = objetoEncima != null and objetoEncima.tipo() == caja
	method objetoEnManos() = objetoEncima
	method agarrarObjeto(unObjeto){objetoEncima = unObjeto}
	method soltarObjeto(){ objetoEncima = null }
	
	method estadoInicial(){
		position = game.center()
		movimientoPermitido = true
		image = "playerDer.png"
		posicionAnterior = position
		vistaActual = "Abajo"
		vistaAnterior = "Abajo"
		objetoEncima = null
		vidas = 3
	}

	method hayColisionConObjetoTipo_(tipoDeObjeto) = game.colliders(self).any({o=>o.tipo() == tipoDeObjeto})
	method hayColisionConObjetoTipo_oTipo_(tipo1,tipo2) = self.hayColisionConObjetoTipo_(tipo1) or self.hayColisionConObjetoTipo_(tipo2)
	method objetoDeTipo_EnColision(tipoDeObjeto) = game.colliders(self).find({o=>o.tipo() == tipoDeObjeto})
}
