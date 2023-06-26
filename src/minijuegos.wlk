import wollok.game.*
import obstaculos.*
import tipos.*
import jugador.*

class Minijuego{
	var puntos = 0
	var minijuegoActivo = true
	var estaEnEstadoCritico = false
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
	method estaEnEstadoCritico() = estaEnEstadoCritico
	method activarEstadoCritico() {estaEnEstadoCritico = true}
	method desactivarEstadoCritico() {estaEnEstadoCritico = false}
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
		posPosiblesX.addAll((3..24).asList())
		posPosiblesY.addAll((1..16).asList())
		self.agregarPrimerosVisuales()
	}
	
	method agregarPrimerosVisuales(){
		
		(1..8).forEach({n=>
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
		posPosiblesX.clear()
		posPosiblesY.clear()
		posPosiblesX.addAll((3..24).asList())
		posPosiblesY.addAll((1..16).asList())
		(1..6).forEach({n=>
			const posParesX = posPosiblesX.filter({p=>p.even()})
			const posParesY = posPosiblesY.filter({p=>p.even()})
			const posImparesX = posPosiblesX.filter({p=>p.odd()})
			const posImparesY = posPosiblesY.filter({p=>p.odd()})
			var posXTrampa = posImparesX.get((0.randomUpTo(posImparesX.size()-1)).truncate(0))
			posPosiblesX.remove(posXTrampa)
			var posYTrampa = posParesY.get((0.randomUpTo(posParesY.size()-1)).truncate(0))
			posPosiblesY.remove(posYTrampa)
			visualesMinijuego.add(new Trampa(position = game.at(posXTrampa,posYTrampa)))
			posXTrampa = posParesX.get((0.randomUpTo(posParesX.size()-1)).truncate(0))
			posPosiblesX.remove(posXTrampa)
			posYTrampa = posImparesY.get((0.randomUpTo(posImparesY.size()-1)).truncate(0))
			posPosiblesY.remove(posYTrampa)
			visualesMinijuego.add(new Trampa(position = game.at(posXTrampa,posYTrampa)))
		})
		visualesMinijuego.add(new DecoAtravesable(image = "cartelCajaPlaca.png",position = game.at(14,17)))
	}
	
	method recibirAccion(unaPlaca){
		self.sumarUnPunto()
	}
	
	override method minijuegoCompletado() = puntos == 8
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
	method recibirAccion(unaPalanca){
		combinacionIngresada.add(unaPalanca.id())
		if(combinacionIngresada.get(puntos) == listaCombinacion.get(puntos)){
			self.desactivarEstadoCritico()
			self.sumarUnPunto()			
		}else{
			self.activarEstadoCritico()
			combinacionIngresada.clear()
			puntos = 0
			visualesMinijuego.filter({v=>v.tipo() == palanca}).forEach({p=>p.estadoInicial()})
		}
	}
	
	override method minijuegoCompletado() = puntos == 6 and combinacionIngresada == listaCombinacion
}

class MinijuegoPasillo inherits Minijuego{
	const lamparas = []
	var cantLamparasPrendidas = 0
	method initialize(){
		(1..2).forEach({ n =>
			lamparas.add(new LamparaNivel(position = game.at(11+n,17),id = n-1))
			lamparas.add(new LamparaNivel(position = game.at(14+n,17),id = n+1))
		})
		visualesMinijuego.addAll(lamparas)
	}
	override method minijuegoCompletado() = cantLamparasPrendidas == 4
	override method estadoInicial(){
		cantLamparasPrendidas = 0
		lamparas.forEach({l=>l.estadoInicial()})
	}
	method nivel_Completado(idNivel){
		lamparas.find({l=>l.id() == idNivel}).encender()
		cantLamparasPrendidas++
	}
}


class MinijuegoBloquesFormas inherits Minijuego{
	const posPosiblesX = []
	const posPosiblesY = []
	const formas = ["Circulo","Cuadrado","Estrella","Luna","Corazon","Diamante","Manzana","Rombo","Triangulo"]
	
	method initialize(){
		self.estadoInicial()
	}
	
	override method estadoInicial(){
		puntos = 0
		minijuegoActivo = true
		posPosiblesX.clear()
		posPosiblesY.clear()
		visualesMinijuego.clear()
		posPosiblesX.addAll((3..11).asList())
		posPosiblesX.addAll((15..24).asList())
		posPosiblesY.addAll((1..6).asList())
		posPosiblesY.addAll((10..16).asList())
		formas.clear()
		formas.addAll(["Circulo","Cuadrado","Estrella","Luna","Corazon","Diamante","Manzana","Rombo","Triangulo"])
		self.agregarPrimerosVisuales()
		self.desactivarEstadoCritico()
	}
	
	method agregarPrimerosVisuales(){
		(1..3).forEach({n=>
			var unaForma = formas.get(0.randomUpTo(formas.size()-1).truncate(0))
			formas.remove(unaForma)
			visualesMinijuego.add(new PlacaRompeCabeza(position = game.at(n+12,8), forma = unaForma))
			unaForma = formas.get(0.randomUpTo(formas.size()-1).truncate(0))
			formas.remove(unaForma)
			visualesMinijuego.add(new PlacaRompeCabeza(position = game.at(n+12,9), forma = unaForma))
			unaForma = formas.get(0.randomUpTo(formas.size()-1).truncate(0))
			formas.remove(unaForma)
			visualesMinijuego.add(new PlacaRompeCabeza(position = game.at(n+12,10), forma = unaForma))
		})
		formas.clear()
		formas.addAll(["Circulo","Cuadrado","Estrella","Luna","Corazon","Diamante","Manzana","Rombo","Triangulo"])
		(1..9).forEach({n2=>
			const unaForma = formas.get(0.randomUpTo(formas.size()-1).truncate(0))
			formas.remove(unaForma)
			const posX = posPosiblesX.get((0.randomUpTo(posPosiblesX.size()-1)).truncate(0))
			posPosiblesX.remove(posX)
			const posY = posPosiblesY.get((0.randomUpTo(posPosiblesY.size()-1)).truncate(0))
			posPosiblesY.remove(posY)
			visualesMinijuego.add(new BloqueForma(position = game.at(posX,posY), forma = unaForma, image = "forma"+unaForma+".png"))
		})
		visualesMinijuego.add(new DecoAtravesable(image = "cartelFormas.png",position = game.at(14,17)))
	}
	
	method recibirAccion(unaPlaca){
		const bloque = game.getObjectsIn(unaPlaca.position()).find({o=>o.tipo() == bloqueForma})
		if(unaPlaca.forma() == bloque.forma()){
			self.desactivarEstadoCritico()
			self.sumarUnPunto()			
		}else{
			self.activarEstadoCritico()
			visualesMinijuego.forEach({p=>p.estadoInicial()})
			puntos = 0
		}
	}
	
	override method minijuegoCompletado() = puntos == 9
}

class MinijuegoSimon inherits Minijuego{
	const listaCombinacionInicial = []
	const listaCombinacion = []
	const combinacionIngresada = []
	const listaColores = ["Rojo","Azul","Amarillo","Verde","Azul","Verde","Rojo","Amarillo","Rojo"]
	var jugada = 0
	var jugadasPrevistas = 0
	var pos = 0
	
	method initialize(){
		self.estadoInicial()
	}
	
	override method estadoInicial() {
		minijuegoActivo = true
		estaEnEstadoCritico = false
		puntos = 0
		jugada = 0
		jugadasPrevistas = 0
		pos = 0
		combinacionIngresada.clear()
		listaCombinacion.clear()
		visualesMinijuego.clear()
		listaCombinacionInicial.clear()
		self.agregarPrimerosVisuales()
		(1..6).forEach({n=>
			listaCombinacionInicial.add(listaColores.get((0.randomUpTo(listaColores.size()-1)).truncate(0)))
		})
		listaCombinacion.add(listaCombinacionInicial.get(0))
	}
	
	method agregarPrimerosVisuales(){
		visualesMinijuego.add(new PlacaSimon(id = "Rojo", image = "placaSimonRojo.png", position = game.at(15,9)))
		visualesMinijuego.add(new PlacaSimon(id = "Verde", image = "placaSimonVerde.png", position = game.at(15,10)))
		visualesMinijuego.add(new PlacaSimon(id = "Azul", image = "placaSimonAzul.png", position = game.at(14,9)))
		visualesMinijuego.add(new PlacaSimon(id = "Amarillo", image = "placaSimonAmarillo.png", position = game.at(14,10)))
		visualesMinijuego.add(new DecoNoAtravesable(image = "teleSimon.png", position = game.at(15,13)))
		visualesMinijuego.add(new Palanca(id = 1, position = game.at(14,13)))
		visualesMinijuego.add(new DecoAtravesable(image = "cartelSimon.png",position = game.at(14,17)))
	}
	
	method verificarPosicionColor(unaPos) {
		pos++
		return combinacionIngresada.get(unaPos) == listaCombinacion.get(unaPos)
	}
	
	method verificarColores(){
		pos = 0
		return combinacionIngresada.all({c=>self.verificarPosicionColor(pos)})
	}
	
	method mostrarCombinacion(){
		var tiempoFijo = 500
		const tele = visualesMinijuego.find({v=>v.tipo()==decoracion})
		(1..jugadasPrevistas+1).forEach({n=>
			game.schedule(tiempoFijo,{
				tele.image("teleSimon"+listaCombinacion.get(n-1)+".png")
			})
			game.schedule(tiempoFijo+500,{
				tele.image("teleSimonColores.png")
			})
			tiempoFijo+=1000
		})
	}
	
	method recibirAccion(objeto){
		if(minijuegoActivo){	
			if(objeto.tipo() == palanca){
				self.mostrarCombinacion()
			}else if(objeto.tipo() == placaSimon){
				combinacionIngresada.add(objeto.id())
				if(jugada == jugadasPrevistas and self.verificarColores()){
					self.desactivarEstadoCritico()
					self.sumarUnPunto()
					combinacionIngresada.clear()
					jugada = 0	
					listaCombinacion.add(listaCombinacionInicial.get(jugadasPrevistas))
					jugadasPrevistas++	
					if(self.minijuegoCompletado()){
						visualesMinijuego.find({v=>v.tipo()==decoracion}).image("teleSimon.png")
					}else{						
						self.mostrarCombinacion()
					}
				}else if(jugada < jugadasPrevistas){
					jugada++
				}else{
					self.activarEstadoCritico()
					combinacionIngresada.clear()
					listaCombinacion.add(listaCombinacionInicial.get(0))
					puntos = 0
					jugada = 0
					visualesMinijuego.forEach({p=>p.estadoInicial()})
				}
			}
		}
	}
	

	override method minijuegoCompletado() = puntos == 6
}


