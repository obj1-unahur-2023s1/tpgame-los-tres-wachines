import wollok.game.*
import obstaculos.*

class Minijuego{
	var minijuegoActivo = true
	const visualesMinijuego = []
	
	method mostrarVisuales(){
		if(!visualesMinijuego.isEmpty()){			
			visualesMinijuego.forEach({v=>game.addVisual(v)})
		}
	}
	
	method esconderVisuales(){
		if(!visualesMinijuego.isEmpty()){			
			visualesMinijuego.forEach({v=>game.removeVisual(v)})
		}
	}
	
	method agregarVisual(unVisual) {
		visualesMinijuego.add(unVisual)
	}
	
	method removerElemento(elemento){
		visualesMinijuego.remove(elemento)
	}
	
	method minijuegoCompletado() 
	method minijuegoEstaActivo() = minijuegoActivo
	method desactivarMinijuego(){minijuegoActivo = false}
}

class MinijuegoCajasPlacas inherits Minijuego{
	var cantPlacasActivas = 0
	const posPosiblesX = []
	const posPosiblesY = []
	
	method initialize(){
		self.estadoInicial()
		(1..4).forEach({n=>
			const posParesX = posPosiblesX.filter({p=>p.even()})
			const posParesY = posPosiblesY.filter({p=>p.even()})
			const posImparesX = posPosiblesX.filter({p=>p.odd()})
			const posImparesY = posPosiblesY.filter({p=>p.odd()})
			const posXCaja = posParesX.get((0.randomUpTo(posParesX.size()-1)).truncate(0))
			posPosiblesX.remove(posXCaja)
			const posYCaja = posParesY.get((0.randomUpTo(posParesY.size()-1)).truncate(0))
			posPosiblesY.remove(posYCaja)
			const posXPlaca = posImparesX.get((0.randomUpTo(posImparesX.size()-1)).truncate(0))
			posPosiblesX.remove(posXPlaca)
			const posYPlaca = posImparesY.get((0.randomUpTo(posImparesY.size()-1)).truncate(0))
			posPosiblesY.remove(posYPlaca)
			visualesMinijuego.add(new CajaMadera(position = game.at(posXCaja,posYCaja))) 
			visualesMinijuego.add(new PlacaPresion(position = game.at(posXPlaca,posYPlaca)))
		})
	}
	
	method estadoInicial(){
		posPosiblesX.clear()
		posPosiblesY.clear()
		posPosiblesX.addAll((2..24).asList())
		posPosiblesY.addAll((1..16).asList())
	}
	
	method sumarUnaPlaca(){cantPlacasActivas++}
	
	override method minijuegoCompletado() = cantPlacasActivas == 4

}


class MinijuegoPalancas inherits Minijuego{
	var cantPalancasActivas = 0
	const listaIdPalancas = []
	const listaCombinacion = []
	const combinacionIngresada = []
	
	method initialize(){
		self.estadoInicial()
		(1..6).forEach({n=>
			const numComb = listaIdPalancas.get((0.randomUpTo(listaIdPalancas.size()-1)).truncate(0))
			listaIdPalancas.remove(numComb)
			listaCombinacion.add(numComb)
			visualesMinijuego.add(new Palanca(position = game.at(6+n*2,9), id = n)) 
			visualesMinijuego.add(new DecoAtravesable(image = "numero"+numComb+".png",position = game.at(6+n*2,17)))
		})
	}
	
	method estadoInicial() {
		combinacionIngresada.clear()
		listaIdPalancas.addAll((1..6).asList())
		listaCombinacion.clear()
	}
	
	method sumarUnaPalanca(idPalanca){
		cantPalancasActivas++
		combinacionIngresada.add(idPalanca)
	}
	
	override method minijuegoCompletado() = cantPalancasActivas == 6 and combinacionIngresada == listaCombinacion
}

class MinijuegoPasillo inherits Minijuego{
	method minijuegoCompletado() = false
}


