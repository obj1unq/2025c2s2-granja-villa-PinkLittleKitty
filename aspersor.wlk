import wollok.game.*
import personaje.*
import directions.*

class Sprinkler {
    var property position = game.center()
    const property image = "aspersor.png"

    method isCrop() {
        return false
    }

    method water() {
        const directions = self.getDirections()
        const crops = self.cropsIn(directions)
        self.waterCrops(crops)
    }

    method getDirections() {
        const directions = [norte, sur, este, oeste, noreste, noroeste, sureste, suroeste]

        return directions.map({ dir =>
            dir.siguiente(self.position())
        })
    }

    method cropsIn(directions) {
  
        return directions.map({ pos => personaje.getCrops(pos) })
    }

    method waterCrops(crops) {
        crops.forEach({ list => list.forEach({ c => c.water() }) })
    }

    method setup() {
        game.onTick(1000, "aspersor", { self.water() })
    }
}