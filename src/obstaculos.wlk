import tiposDeObstaculos.*

class BloquePared{
	var property position
	var property image = "pared.png"
	var property tipo = pared
}

class Pinche {
	var property image = "malo.png"
	var property position
	var property tipo = trampa
}

class CartelMuerte{
	var property image = "ct2.png"
	var property position
	var property tipo = pared
}

class CajaMadera{
	var property image = "caja2.png"
	var property position
	var property tipo = caja 
	var property estaSiendoAgarrada = false
}