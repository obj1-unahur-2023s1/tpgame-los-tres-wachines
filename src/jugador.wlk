import wollok.game.*
import obstaculos.*
import tipos.*
import hud.*

object alex {
	var property position = game.center()
	var movimientoPermitido = true
	var property image = "Alex/playerDer.png"
	var posicionAnterior = position
	var property vistaActual = "Abajo"
	var vistaAnterior = "Abajo"
	var objetoEncima = null
	var vidas = 3
	var recibioDanio = false
	var pasoNro = 1
	
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
	
	method hayObstaculo_Adelante(tipoDeObjeto) = self.obtenerObjetosAdelante().any({o => o.esDeTipo(tipoDeObjeto)})
	
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
	method sumarUnaVida() {vidas = 3.min(vidas+1)}
	method recibirDanio() {
		self.bloquearMovimiento()
		recibioDanio = true
		vidas = 0.max(vidas-1)
		game.schedule(200, {
			self.actualizarVisualConDanio()
			position = posicionAnterior
		})
		game.schedule(500, {
			if(self.estaMuerto()){
				image = "Alex/alexMuerte"+self.vistaMuerte()+"0.png"
				game.schedule(500,{
					image = "Alex/alexMuerte"+self.vistaMuerte()+"1.png"
				})
			}else{			
				if(self.tieneLasManosOcupadas() and self.objeto_DeTipo_(objetoEncima,caja)){	
					image = "Alex/player"+vistaActual+"Caja.png"
				}else {
					image = "Alex/player"+vistaActual+".png"
				}
			}
		})
		game.schedule(900, {
			if(!self.estaMuerto()){
				self.permitirMovimiento()
			}
			recibioDanio = false				
		})
	}
	method vistaMuerte() {
		if( vistaActual == "Der" or vistaActual == "Abajo"){
			return "Der"
		}else{
			return "Izq"
		}
	}
	
	method estaMuerto() = vidas == 0

	// --- IMAGEN ---
	
	method actualizarVisual(){
		if(self.tieneLasManosOcupadas() and self.objeto_DeTipo_(objetoEncima,caja)){	
			image = "Alex/player"+vistaActual+"Caja.png"
		}else {
			image = "Alex/player"+vistaActual+pasoNro+".png"
			game.schedule(50,{
				self.bloquearMovimiento()
			})
			game.schedule(200,{	
				if(!recibioDanio){
					image = "Alex/player"+vistaActual+".png"					
					self.permitirMovimiento()
				}			
			})
		}
		self.darUnPaso()
	}
	
	method actualizarVisualConDanio(){
		if(self.tieneLasManosOcupadas() and self.objeto_DeTipo_(objetoEncima,caja)){	
			image = "Alex/player"+vistaActual+"DañoConCaja.png"
		}else {
			image = "Alex/player"+vistaActual+"Daño.png"
		}
	}
	
	method image() = image
	method darUnPaso(){
		if(pasoNro == 1){
			pasoNro++
		}else{
			pasoNro--
		}
	}
	
	
	// --- COLISION Y ACCIONES---
	
	method objeto_DeTipo_(objeto,tipoDeObjeto) = objeto.esDeTipo(tipoDeObjeto)
	method tipo() = personaje
	method tieneLasManosOcupadas() = objetoEncima != null 
	method objetoEnManos() = objetoEncima
	method agarrarObjeto(unObjeto){objetoEncima = unObjeto}
	method soltarObjeto(){ objetoEncima = null }
	
	method estadoInicial(){
		position = game.center()
		movimientoPermitido = true
		posicionAnterior = position
		vistaActual = "Abajo"
		vistaAnterior = "Abajo"
		image = "Alex/player"+vistaActual+".png"
		objetoEncima = null
		vidas = 3
	}

	method hayColisionConObjetoTipo_(tipoDeObjeto) = game.colliders(self).any({o=>o.esDeTipo(tipoDeObjeto)})
	method hayColisionConObjetoTipo_oTipo_(tipo1,tipo2) = self.hayColisionConObjetoTipo_(tipo1) or self.hayColisionConObjetoTipo_(tipo2)
	method objetoDeTipo_EnColision(tipoDeObjeto) = game.colliders(self).find({o=>o.esDeTipo(tipoDeObjeto)})
}
