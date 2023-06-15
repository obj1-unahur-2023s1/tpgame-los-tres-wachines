import wollok.game.*
class Habitacion {
	const nombre
	const visuales = []

	method visuales() = visuales
	method agregarVisual(unVisual) {visuales.add(unVisual)}
	method nombre() = nombre
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
}
