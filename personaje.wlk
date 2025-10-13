import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method isCultivo() {
		return false
	}

	method sembrar(planta) {
		game.addVisual(planta)
		planta.position(self.position())
	}

	method intentarSembrar(planta) {
		if (self.puedeSembrar(self.position())) {
			self.sembrar(planta)
		}
		else {
			game.error("No se puede sembrar aquí")
		}
	}

	method puedeSembrar(_position)
	{
		return game.getObjectsIn(_position).size() <= 1
	}

	method regar(_position) {
		self.getCultivos(_position).forEach({ c => c.regar() })
	}

	method getCultivos(_position) {
		return game.getObjectsIn(_position).filter({obj => obj.isCultivo()})
	}

	method intentarRegar() {
		if (self.puedeRegar(self.position())) {
			self.regar(self.position())
		}
		else {
			game.error("No tengo nada para regar")
		}
	}

	method puedeRegar(_position)
	{
		return self.getCultivos(_position).size() > 0
	}

	method cosechar() {

	}
}