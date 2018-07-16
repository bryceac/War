import Foundation

class Assets {
    var cards: [Card] = [Card]()
    
    init() {
        let suits: [String] = ["Clubs", "Diamonds", "Hearts", "Spades"]
        let names: [String] = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
        
        for suit in suits {
            
            for name in names {
                let rank = names.index(of: name)!+1
                let card = Card(name: name, rank: rank, suit: suit)
                cards.append(card)
            }
        }
    } // end init statement
    
    func shuffled(cards: [Card]) -> [Card] {
        var deck = [Card]()
        deck.append(contentsOf: cards)
        
        for _ in 0..<cards.count {
            let rand = RandomGen(number: cards.count)
            deck.append(cards[rand])
            deck.remove(at: rand)
        }
        
        return deck
    }
} // end class
