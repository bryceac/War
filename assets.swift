import Foundation

class Assets {
    var cards: [Card] = [Card]()
    var opponents: [Character] = [Character]()
    
    init() {
        cards.append(contentsOf: loadCards()) // use functions to load data
        opponents.append(contentsOf: loadOpponents()) // use functions to load data
    } // end init statement
    
    // function to load cards
    func loadCards() -> [Card] {
        let file = Bundle.main.path(forResource: "cards", ofType: "json") // JSON file that holds cards
        let decoder = JSONDecoder() // variable to use JSONDecoder
        
        // check if file exists, and if it does load it
        if (file != nil) {
            do {
                let contents = try Data(String(contentsOfFile: file!, encoding: .utf8).utf8)
                let pCards = try decoder.decode(CardList.self, from: contents)
                return pCards.cards
            } catch {
                return [Card]()
            }
        } else {
            print("could not load file")
            return [Card]()
        }
    }
    
    // function to load opponents
    func loadOpponents() -> [Character] {
        let file = Bundle.main.path(forResource: "characters", ofType: "json") // JSON file that holds cards
        let decoder = JSONDecoder() // variable to use JSONDecoder
        
        // check if file exists, and if it does load it
        if (file != nil) {
            do {
                let contents = try Data(String(contentsOfFile: file!, encoding: .utf8).utf8)
                let characters = try decoder.decode(CharacterList.self, from: contents)
                return characters.characters
            } catch {
                return [Character]()
            }
        } else {
            print("could not load file")
            return [Character]()
        }
    }
    
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
