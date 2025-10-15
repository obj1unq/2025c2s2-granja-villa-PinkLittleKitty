import wollok.game.*
import personaje.*

class Maiz {
	var property position = game.center()
	var property watered = false

	method isCrop() {
		return true
	}

	method isMarket() {
        return false
    }

	method image() {
		if (watered) {
			return "corn_adult.png"
		} else {
			return "corn_baby.png"
		}
	}

	method water() {
		if (!watered) {
			watered = true
		}
	}

	method tryHarvest() {
		if (watered) {
			personaje.inventory().add(self)
			game.removeVisual(self)
		} else {
			self.error("No está listo para cosechar")
		}
	}

	method price() {
		return 150
	}
}

class Trigo {
	var property position = game.center()
	var stage = 0

	method isCrop() {
		return true
	}

	method isMarket() {
        return false
    }

	method image() {
		return "wheat_" + stage + ".png"
	}

	method water() {
		self.nextStage()
	}

	method nextStage() {
		if (stage < 3) {
			stage = stage + 1
		} else {
			stage = 0
		}
	}

	method tryHarvest() {
		if (stage >= 2) {
			personaje.inventory().add(self)
			game.removeVisual(self)
		} else {
			self.error("No está listo para cosechar")
		}
	}

	method price() {
		return (stage - 1) * 100
	}
}

class Tomaco {
	var property position = game.center()

	method isCrop() {
		return true
	}

	method isMarket() {
        return false
    }

	method image() {
		return "tomaco.png"
	}

	method water() {
		if (self.position().y() != game.height() - 1 && self.canMove()) {
			self.position(game.at(self.position().x(), self.position().y() + 1))
		} else if (self.canMove()) {
			self.position(game.at(self.position().x(), 0))
		}
	}

	method canMove() {
		return game.getObjectsIn(game.at(self.position().x(), self.position().y() + 1)).size() == 0
	}

	method tryHarvest() {
		personaje.inventory().add(self)
		game.removeVisual(self)
	}

	method price() {
		return 80
	}
}