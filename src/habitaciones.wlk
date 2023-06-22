import wollok.game.*
import obstaculos.*
import tipos.*
import jugador.*


class Habitacion{
	var id
	const visuales = []
	var minijuego 
	
	method id() = id
	method minijuego() = minijuego
	method visuales() = visuales
	method agregarVisual(unVisual) {visuales.add(unVisual)}
	method agregarVisuales(listaDeVisuales) {visuales.addAll(listaDeVisuales)}
	method mostrarVisuales() {
		if(!visuales.isEmpty()){			
			visuales.forEach({v=>game.addVisual(v)})
		}
		minijuego.mostrarVisuales()
	}
	method esconderVisuales(){
		if(!visuales.isEmpty()){			
			visuales.forEach({v=>game.removeVisual(v)})
		}
		minijuego.esconderVisuales()
	}
	method removerVisualesDeTipo_En_(tipo,pos){
		const objetosARemover = game.getObjectsIn(pos).filter({o => o.tipo() == tipo})
		objetosARemover.forEach({o => game.removeVisual(o)})
		visuales.removeAll(objetosARemover)
	}
	method removerElemento(elemento){
		visuales.remove(elemento)
	}
	
	method estadoInicial(){
		visuales.forEach({v=>v.estadoInicial()})
		minijuego.estadoInicial()
	}
	method actualizarEstado(){}
}

class PasilloPrincipal inherits Habitacion{
	method initialize(){
		var idPuerta = 0
		(1..16).forEach({posY =>
			if(posY%4!=0 or posY == 16){
				visuales.add(new Pared(position = game.at(6,posY),image = "paredIzq.png"))
				visuales.add(new Pared(position = game.at(22,posY),image = "paredDer.png"))	
			}else if(posY%4==0 and posY<16){
				visuales.add(new PuertaIzq(position = game.at(6,posY), id = idPuerta))
				visuales.add(new PuertaDer(position = game.at(22,posY), id = idPuerta+3))
				idPuerta += 1
			}
		})
		visuales.add(new Portal(position = game.at(14,16),id = 666))
	}
	
	override method estadoInicial(){
		super()
		self.mostrarVisuales()
	}
	override method actualizarEstado(){
		if(minijuego.minijuegoCompletado()){
			const portalFinal = visuales.find({v => v.tipo() == puerta and v.id() == 666})
			minijuego.desactivarMinijuego()
			portalFinal.desbloquearPuerta()
		}
	}
}

class HabitacionIzq inherits Habitacion{
	override method initialize(){
		(1..16).forEach({posY =>
			if(posY != 9){
				visuales.add(new Pared(position = game.at(27,posY),image = "paredDer.png"))
			}else{
				const puertaDer = new PuertaDer(position = game.at(27,9), id = 10)
				visuales.add(puertaDer)
				puertaDer.bloquearPuerta()
			}
		})
	}
	override method estadoInicial(){
		super()
		visuales.find({v=>v.tipo() == puerta}).bloquearPuerta()
	}
	method abrirPuertas(){
		visuales.find({v=>v.tipo() == puerta}).estadoInicial()
	}
}


class HabitacionDer inherits HabitacionIzq{
	override method initialize(){
		(1..16).forEach({posY =>
			if(posY != 9){
				visuales.add(new Pared(position = game.at(1,posY),image = "paredIzq.png"))
			}else{
				const puertaIzq = new PuertaIzq(position = game.at(1,9), id = 10)
				visuales.add(puertaIzq)
				puertaIzq.bloquearPuerta()
			}
		})
	}
}
