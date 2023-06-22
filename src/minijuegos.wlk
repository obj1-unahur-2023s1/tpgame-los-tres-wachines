import wollok.game.*
import obstaculos.*
import tipos.*

class Minijuego{
	var puntos = 0
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
	
	method sumarUnPunto(){
		puntos++
	}
	
	method minijuegoCompletado() 
	method minijuegoEstaActivo() = minijuegoActivo
	method desactivarMinijuego(){minijuegoActivo = false}
	method estadoInicial()
}

class MinijuegoCajasPlacas inherits Minijuego{
	const posPosiblesX = []
	const posPosiblesY = []
	
	method initialize(){
		self.estadoInicial()
	}
	
	override method estadoInicial(){
		puntos = 0
		minijuegoActivo = true
		posPosiblesX.clear()
		posPosiblesY.clear()
		visualesMinijuego.clear()
		posPosiblesX.addAll((2..24).asList())
		posPosiblesY.addAll((1..16).asList())
		self.agregarPrimerosVisuales()
	}
	
	method agregarPrimerosVisuales(){
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
	
	override method minijuegoCompletado() = puntos == 4
}


class MinijuegoPalancas inherits Minijuego{
	const listaIdPalancas = []
	const listaCombinacion = []
	const combinacionIngresada = []
	
	method initialize(){
		self.estadoInicial()
	}
	
	override method estadoInicial() {
		puntos = 0
		minijuegoActivo = true
		combinacionIngresada.clear()
		listaCombinacion.clear()
		visualesMinijuego.clear()
		listaIdPalancas.addAll((1..6).asList())
		self.agregarPrimerosVisuales()
	}
	
	method agregarPrimerosVisuales(){
		(1..6).forEach({n=>
				const numComb = listaIdPalancas.get((0.randomUpTo(listaIdPalancas.size()-1)).truncate(0))
				listaIdPalancas.remove(numComb)
				listaCombinacion.add(numComb)
				visualesMinijuego.add(new Palanca(position = game.at(6+n*2,9), id = n)) 
				visualesMinijuego.add(new DecoAtravesable(image = "numero"+numComb+".png",position = game.at(6+n*2,17)))
		})
	}
	method sumarUnPuntoId(idPalanca){
		self.sumarUnPunto()
		combinacionIngresada.add(idPalanca)
	}
	
	override method minijuegoCompletado() = puntos == 6 and combinacionIngresada == listaCombinacion
}

class MinijuegoPasillo inherits Minijuego{
	const lamparas = []
	var cantLamparasPrendidas = 0
	method initialize(){
		(1..3).forEach({ n =>
			lamparas.add(new LamparaNivel(position = game.at(10+n,17),id = n-1))
			lamparas.add(new LamparaNivel(position = game.at(14+n,17),id = n+2))
		})
		visualesMinijuego.addAll(lamparas)
	}
	override method minijuegoCompletado() = cantLamparasPrendidas == 6
	override method estadoInicial(){
		cantLamparasPrendidas = 0
		lamparas.forEach({l=>l.apagar()})
	}
	method nivel_Completado(idNivel){
		lamparas.get(idNivel).encender()
		cantLamparasPrendidas++
	}
}


