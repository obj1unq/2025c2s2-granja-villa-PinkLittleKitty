import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method isCultivo() {
		return false
	}

	method plant(planta) {
		game.addVisual(planta)
		planta.position(self.position())
	}

	method tryPlant(planta) {
		if (self.canPlant(self.position())) {
			self.plant(planta)
		}
		else {
			game.error("No se puede sembrar aquí")
		}
	}

	method canPlant(_position)
	{
		return game.getObjectsIn(_position).size() <= 1
	}

	method water(_position) {
		self.getCultivos(_position).forEach({ c => c.regar() })
	}

	method getCultivos(_position) {
		return game.getObjectsIn(_position).filter({obj => obj.isCultivo()})
	}

	method tryWater() {
		if (self.canWater(self.position())) {
			self.water(self.position())
		}
		else {
			game.error("No tengo nada para regar")
		}
	}

	method canWater(_position)
	{
		return self.getCultivos(_position).size() > 0
	}

	method harvest() {
		self.getCultivos(self.position()).forEach({ c => c.tryHarvest() })
	}
}