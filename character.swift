import Foundation

// character class is a generic class for players in game
class Character {
    let name: String // variable to hold name of player
    var card: Card? // variable used to deal with revealed card
    var cards: [Card] = [Card]() // variable to handle cards in play
    var deck: [Card] = [Card]() // variable that holds drawable cards
    var discard: [Card] = [Card]() // variable to house discarded cards
    
    init(name: String) {
        self.name = name
    }
    
    // function to allow players to shuffle cards back into deck
    func shuffle(supply: [Card]) -> [Card]
    {
        var pile = [Card]()
        pile.append(contentsOf: supply)
        
        for _ in 0..<supply.count {
            let rand = RandomGen(number: supply.count)
            pile.append(supply[rand])
            pile.remove(at: rand)
        }
        
        return pile
    }
    
    func isAlive() -> Bool {
        if (self.deck.count <= 0 && self.discard.count <= 0) {
            return false
        }
        return true
    }
    
    // function use to deal out cards
    func deal(player: Character, supply: [Card]) {
        var pile = [Card]()
        pile.append(contentsOf: supply)
        for _ in 0..<26 {
            var idx = pile.index(where: { $0.name == pile.first!.name && $0.suit == pile.first!.suit })
            player.deck.append(pile[idx!])
            pile.remove(at: idx!)
            idx = pile.index(where: { $0.name == pile.first!.name && $0.suit == pile.first!.suit })
            self.deck.append(pile[idx!])
            pile.remove(at: idx!)
        } // end loop
    }
} // end class
