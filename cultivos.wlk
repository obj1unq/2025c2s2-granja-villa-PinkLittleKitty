import wollok.game.*

class Maiz {
	var property position = game.center()
	var regado = false

	method isCultivo() {
		return true
	}

	method image() {
		if (regado) {
			return "corn_adult.png"
		} else {
			return "corn_baby.png"
		}
	}

	method regar() {
		if (!regado) {
			regado = true
		} else {
			game.error("No se puede regar más")
		}
	}
}

class Trigo {
	var property position = game.center()
	var etapa = 0

	method isCultivo() {
		return true
	}

	method image() {
		return "wheat_" + etapa + ".png"
	}

	method regar() {
		self.siguienteEtapa()
	}

	method siguienteEtapa() {
		if (etapa < 3) {
			etapa = etapa + 1
		} else {
			etapa = 0
		}
	}
}

class Tomaco {
	var property position = game.center()

	method isCultivo() {
		return true
	}

	method image() {
		return "tomaco.png"
	}

	method regar() {
		if (self.position().y() != game.height() - 1) {
			self.position(game.at(self.position().x(), self.position().y() + 1))
		} else {
			self.position(game.at(self.position().x(), 0))
		}
	}
}