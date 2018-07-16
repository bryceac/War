import Foundation

class Assets {
    var cards: [Card]
    
    init() {
        let file = Bundle.main.path(forResource: "cards", ofType: "json") // JSON file that holds cards
        let decoder = JSONDecoder() // variable to use JSONDecoder
        
        // check if file exists, and if it does load it
        if (file != nil) {
            do {
                let contents = try Data(String(contentsOfFile: file!, encoding: .utf8).utf8)
                let pCards = try decoder.decode(CardList.self, from: contents)
                cards = pCards.cards
            } catch {
               cards = [Card]()
            }
        } else {
            print("could not load file")
            cards = [Card]()
        }
    } // end init statement
    
    func shuffled(supply: [Card]) -> [Card] {
        var deck = [Card]()
        deck.append(contentsOf: supply)
        
        for _ in 0..<supply.count {
            let rand = RandomGen(number: cards.count)
            deck.append(supply[rand])
            deck.remove(at: rand)
        }
        
        return deck
    }
} // end class
