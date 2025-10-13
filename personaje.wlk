import wollok.game.*
import cultivos.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var property inventory = []
	var gold = 0

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

	method sell() {
		var total = 0

		self.inventory().forEach({ item =>
			total += item.price()
		})
		gold += total
		self.inventory().clear()
		game.say(self, "Vendí todo por " + total + " de oro")
	}

	method info() {
		game.say(self, "Oro: " + gold + " Inventario: " + self.inventory().size() + " items")
	}

	method tryPlace(objeto) {
		self.canPlant()
		self.place(objeto)
	}

	method place(objeto) {
		game.addVisual(objeto)
		objeto.position(self.position())
		objeto.setup()
	}
}