import Foundation

// character class is a generic class for players in game
class Character: Codable {
    let name: String // variable to hold name of player
    var card: Card? = nil // variable used to deal with revealed card
    var cards: [Card] = [Card]() // variable to handle cards in play
    var deck: [Card] = [Card]() // variable that holds drawable cards
    var discard: [Card] = [Card]() // variable to house discarded cards
    
    // initializers
    init(name: String) {
        self.name = name
    }
    
    // needed to decode JSON
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let n = try values.decode(String.self, forKey: .name)
        
        self.init(name: n)
    }
    
    // needed to encode data
    func encode( to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(self.name, forKey: .name)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    // function to allow players to shuffle cards back into deck
    func shuffle(supply: [Card]) -> [Card]
    {
        var pile = [Card]()
        pile.append(contentsOf: supply)
        
        for idx in 0..<pile.count {
            let rand = RandomGen(number: pile.count)
            pile.swapAt(idx, rand)
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

struct CharacterList: Codable {
    let characters: [Character]
}
