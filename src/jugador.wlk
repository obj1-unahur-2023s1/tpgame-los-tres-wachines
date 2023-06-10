import wollok.game.*
import obstaculos.*
import tiposDeObstaculos.*
import hud.*

class Jugador {
	var property position = game.center()
	var property movimientoPermitido = true
	var property image = "playerDer.png"
	var property posicionAnterior = position
	var property vistaActual = "Der"
	var property vistaAnterior = "Der"
	var property cajaEncima = null
	var vidas = 3
	
	// --- MOVIMIENTO ---
	
	method moverArriba(){
		if(movimientoPermitido){
			vistaActual = "Arriba"
			image = "playerArriba.png"
			if(cajaEncima != null){
				image = "playerArribaCaja.png"
				
				}
			if(!self.hayObstaculo_Adelante(bloqueSolido) and vistaAnterior == vistaActual and self.position().y() < game.height()-2){
				posicionAnterior = position
				position = position.up(1)
				if(cajaEncima != null){
					cajaEncima.position(self.position())
				}
			}
			vistaAnterior = vistaActual
		}
	}
	method moverDerecha(){
		if(movimientoPermitido){
			vistaActual = "Der"
			image = "playerDer.png"
			if(cajaEncima != null){
				image = "playerDerCaja.png"
				
				}
			if(!self.hayObstaculo_Adelante(bloqueSolido) and vistaAnterior == vistaActual and self.position().x() < game.width()-2){
				posicionAnterior = position
				position = position.right(1)
				if(cajaEncima != null){
					cajaEncima.position(self.position())
				}
			}
			vistaAnterior = vistaActual	
		}
	}
	method moverIzquierda(){
		if(movimientoPermitido){
			vistaActual = "Izq"
			image = "playerIzq.png"
			if(cajaEncima != null){
				image = "playerIzqCaja.png"
				
				}
			if(!self.hayObstaculo_Adelante(bloqueSolido) and vistaAnterior == vistaActual and self.position().x() > 1){
				posicionAnterior = position
				position = position.left(1)
				if(cajaEncima != null){
					cajaEncima.position(self.position())
				}
			}
			vistaAnterior = vistaActual
		}
	}
	method moverAbajo(){
		if(movimientoPermitido){
			vistaActual = "Abajo"
			image = "playerAbajo.png"
			if(cajaEncima != null){
				image = "playerAbajoCaja.png"
				
				}
			if(!self.hayObstaculo_Adelante(bloqueSolido) and vistaAnterior == vistaActual and self.position().y() > 1){
				posicionAnterior = position
				position = position.down(1)
				if(cajaEncima != null){
					cajaEncima.position(self.position())
				}
			}
			vistaAnterior = vistaActual
		}	
	}
	
	method hayObstaculo_Adelante(tipo){
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
		return game.getObjectsIn(new Position(x = self.position().x()+sumaX, y = self.position().y()+sumaY)).any({o=>o.tipo() == tipo })
	}
	
	// --- VIDAS ---

	method getVidas() = vidas
	method setVidas(cantVidas) {vidas = cantVidas}
	method perderUnaVida() {vidas = 0.max(vidas-1)}
	method sumarUnaVida() {vidas = 6.min(vidas+1)}
		
}
