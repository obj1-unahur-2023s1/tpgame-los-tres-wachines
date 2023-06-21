import wollok.game.*
import obstaculos.*

class PasilloPrincipal{
	var property id
	const visuales = []
	var property minijuego 
	
	method initialize(){
		var idPuerta = 0
		(1..16).forEach({posY =>
			if(posY%4!=0 or posY == 16){
				visuales.add(new Pared(position = game.at(6,posY),image = "paredIzq.png"))
				visuales.add(new Pared(position = game.at(21,posY),image = "paredDer.png"))	
			}else if(posY%4==0 and posY<16){
				visuales.add(new PuertaIzq(position = game.at(6,posY), id = idPuerta))
				visuales.add(new PuertaDer(position = game.at(21,posY), id = idPuerta+3))
				idPuerta += 1
			}
		})
	}
	
	method visuales() = visuales
	method agregarVisual(unVisual) {visuales.add(unVisual)}
	method agregarVisuales(listaDeVisuales) {visuales.addAll(listaDeVisuales)}
	method mostrarVisuales() {
		if(!visuales.isEmpty()){			
			visuales.forEach({v=>game.addVisual(v)})
		}
	}
	method esconderVisuales(){
		if(!visuales.isEmpty()){			
			visuales.forEach({v=>game.removeVisual(v)})
		}
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
		visuales.forEach({
			v=>v.estadoInicial()
		})
		self.mostrarVisuales()
	}
}
class HabitacionIzq inherits PasilloPrincipal{
	
	override method initialize(){
		(1..16).forEach({posY =>
			if(posY != 9){
				visuales.add(new Pared(position = game.at(26,posY),image = "paredDer.png"))
			}else{
				const puertaDer = new PuertaDer(position = game.at(26,9), id = 10,esAtravesable = true, image = "puertaCostadoIzqAbierta2.png")
				const puertaDerDeco = new DecoAtravesable(position = game.at(25,9),image = "puertaCuartoIzqNoOBJETO.png")
				visuales.addAll([puertaDer,puertaDerDeco])
			}
		})
	}
	
	override method mostrarVisuales(){
		super()
		minijuego.mostrarVisuales()
	}
	
	override method esconderVisuales(){
		super()
		minijuego.esconderVisuales()
	}
}


class HabitacionDer inherits HabitacionIzq{
	override method initialize(){
		(1..16).forEach({posY =>
			if(posY != 9){
				visuales.add(new Pared(position = game.at(1,posY),image = "paredIzq.png"))
			}else{
				const puertaIzq = new PuertaIzq(position = game.at(1,9), id = 10,esAtravesable = true)
				puertaIzq.image("puertaCostadoDerAbierta2.png")
				visuales.add(puertaIzq)
			}
		})
	}
}
