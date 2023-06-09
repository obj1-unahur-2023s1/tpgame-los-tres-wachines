import wollok.game.*

object visualVida {
	var property image = "corazon.png"
	var property position = game.at(0,game.height()-1)
}
object cantidadVida {
	var property texto
	var property position = game.at(1,game.height()-1)
	method text() = "x" + texto.toString()
}