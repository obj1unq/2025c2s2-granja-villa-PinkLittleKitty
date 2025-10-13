import wollok.game.*

class Maiz {
	var property position = game.center()
	var watered = false

	method isCrop() {
		return true
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
		} else {
			game.error("No se puede regar más")
		}
	}
}

class Trigo {
	var property position = game.center()
	var stage = 0

	method isCrop() {
		return true
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
}

class Tomaco {
	var property position = game.center()

	method isCrop() {
		return true
	}

	method image() {
		return "tomaco.png"
	}

	method water() {
		if (self.position().y() != game.height() - 1) {
			self.position(game.at(self.position().x(), self.position().y() + 1))
		} else {
			self.position(game.at(self.position().x(), 0))
		}
	}
}