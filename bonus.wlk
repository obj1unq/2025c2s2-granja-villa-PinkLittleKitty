import wollok.game.*
import personaje.*
import directions.*

class Sprinkler {
    var property position = game.center()
    const property image = "aspersor.png"

    method isCrop() {
        return false
    }

    method isMarket() {
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

class Mercado {
    var property position
    const property image = "market.png"
    var property gold = 1000
    var property inventory = []

    method isCrop() {
        return false
    }

    method isMarket() {
        return true
    }

    method buy(cropList) {
        self.canBuy(cropList)
        cropList.forEach({ crop =>
            personaje.inventory().remove(crop)
            personaje.gold(personaje.gold() + crop.price())
            self.inventory().add(crop)
            self.gold(self.gold() - crop.price())
            })
    }

    method canBuy(cropList) {
        const totalPrice = cropList.map({ c => c.price() }).sum()
        if (totalPrice > self.gold()) {
            self.error("No tengo suficiente oro")
        }
    }
}