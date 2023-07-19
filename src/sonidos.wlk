import wollok.game.*

class Sonido{
	const volumen
	const sonido
	const musica = game.sound(sonido)
	method initialize(){
		musica.volume(volumen)
	}
	method play(){
		musica.play()
	}
	method playLoop(){
		musica.shouldLoop(true)
		game.schedule(100, { musica.play()} )
	}
	method stop(){
		musica.stop()
	}
	method pause(){
		musica.pause()
	}
	method resume(){
		musica.resume()
	}
	method played() = self.played()
}


