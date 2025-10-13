import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"

	method isCrop() {
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
		self.getCrops(_position).forEach({ c => c.water() })
	}

	method getCrops(_position) {
		return game.getObjectsIn(_position).filter({obj => obj.isCrop()})
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
		return self.getCrops(_position).size() > 0
	}

	method harvest() {
		self.getCrops(self.position()).forEach({ c => c.tryHarvest() })
	}
}