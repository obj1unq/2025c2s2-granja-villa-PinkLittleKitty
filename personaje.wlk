import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var property inventory = []

	method isCrop() {
		return false
	}

	method plant(planta) {
		game.addVisual(planta)
		planta.position(self.position())
	}


	method tryPlant(planta)
	{
		self.canPlant()
		self.plant(planta)
	}

	method canPlant() {
		if (game.getObjectsIn(self.position()).size() > 1) {
			self.error("No se puede sembrar aquí")
		}
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
			self.error("No tengo nada para regar")
		}
	}

	method canWater(_position)
	{
		return self.getCrops(_position).size() > 0
	}

	method tryHarvest() {
		if (self.getCrops(self.position()).size() > 0) {
			self.getCrops(self.position()).forEach({ c => c.tryHarvest() })
		} else {
			self.error("No hay nada para cosechar")
		}
	}
}