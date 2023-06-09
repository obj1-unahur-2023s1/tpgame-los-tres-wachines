import wollok.game.*
import obstaculos.*
import tiposDeObstaculos.*
import hud.*

class Jugador {
	var property position = game.center()
	var property movimientoPermitido = true
	var property image = "playerDer.png"
	var property posicionAnterior = position
	var property vista = "Der"
	var vidas = 3
	
	method image() = image
	
	method moverArriba(){
		vista = "Arriba"
		image = "playerArriba.png"
		if(movimientoPermitido and !self.hayObstaculo_Adelante(pared)){
			posicionAnterior = position
			position = position.up(1)
		}
	}
	method moverDerecha(){
		image = "playerDer.png"
		vista = "Der"
		if(movimientoPermitido and !self.hayObstaculo_Adelante(pared)){
			posicionAnterior = position
			position = position.right(1)
		}
	}
	method moverIzquierda(){
		image = "playerIzq.png"
		vista = "Izq"
		if(movimientoPermitido and !self.hayObstaculo_Adelante(pared)){
			posicionAnterior = position
			position = position.left(1)
		}
	}
	method moverAbajo(){
		image = "playerAbajo.png"
		vista = "Abajo"
		if(movimientoPermitido and !self.hayObstaculo_Adelante(pared)){
			posicionAnterior = position
			position = position.down(1)
		}
	}
	
	method hayObstaculo_Adelante(tipo){
		if(vista == "Der"){			
			return game.getObjectsIn(new Position (x = self.position().x()+1, y = self.position().y())).any({o=>o.tipo() == tipo })
		}else if(vista == "Izq"){
			return game.getObjectsIn(new Position (x = self.position().x()-1, y = self.position().y())).any({o=>o.tipo() == tipo })
		}else if(vista == "Arriba"){
			return game.getObjectsIn(new Position (x = self.position().x(), y = self.position().y()+1)).any({o=>o.tipo() == tipo })
		}else {
			return game.getObjectsIn(new Position (x = self.position().x(), y = self.position().y()-1)).any({o=>o.tipo() == tipo })
		}
	}
	
	method getVidas() = vidas
	method perderUnaVida() {vidas = 0.max(vidas-1)}
	method sumarUnaVida() {vidas = 6.min(vidas+1)}
		
}
