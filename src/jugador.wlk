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
	var vidas = 3
	var property cajaEncima = null
	
	method image() = image
	
	method moverArriba(){
		if(movimientoPermitido){
			vistaActual = "Arriba"
			image = "playerArriba.png"
			if(movimientoPermitido and !self.hayObstaculo_Adelante(pared) and vistaAnterior == vistaActual){
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
			image = "playerDer.png"
			vistaActual = "Der"
			if(movimientoPermitido and !self.hayObstaculo_Adelante(pared) and vistaAnterior == vistaActual){
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
			image = "playerIzq.png"
			vistaActual = "Izq"
			if(!self.hayObstaculo_Adelante(pared) and vistaAnterior == vistaActual){
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
			image = "playerAbajo.png"
			vistaActual = "Abajo"
			if(!self.hayObstaculo_Adelante(pared) and vistaAnterior == vistaActual){
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
		if(vistaActual == "Der"){			
			return game.getObjectsIn(new Position (x = self.position().x()+1, y = self.position().y())).any({o=>o.tipo() == tipo })
		}else if(vistaActual == "Izq"){
			return game.getObjectsIn(new Position (x = self.position().x()-1, y = self.position().y())).any({o=>o.tipo() == tipo })
		}else if(vistaActual == "Arriba"){
			return game.getObjectsIn(new Position (x = self.position().x(), y = self.position().y()+1)).any({o=>o.tipo() == tipo })
		}else {
			return game.getObjectsIn(new Position (x = self.position().x(), y = self.position().y()-1)).any({o=>o.tipo() == tipo })
		}
	}
	
	method getVidas() = vidas
	method setVidas(cantVidas) {vidas = cantVidas}
	method perderUnaVida() {vidas = 0.max(vidas-1)}
	method sumarUnaVida() {vidas = 6.min(vidas+1)}
		
}
