import Foundation

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

class War {
    var players: [Character] = [Character]()
    let dialog: Dialogue
    
    // initialization method, so that game can work properly
    init(player: Character, opponent: Character) {
        players.append(player)
        players.append(opponent)
        dialog = Dialogue(report: "What are you going to do?", choices: ["Draw", "Quit"])
    }
    
    func compare(card1: Card, card2: Card) -> Bool {
        if (card1.name != "Ace" && card2.name != "Ace") {
            if (card1.rank > card2.rank) {
                return true
            } else if (card1.rank < card2.rank) {
                return false
            } else {
                return false
            }
        } else {
            if (card1.name == "Ace" && card2.rank == 4) {
                return false
            } else if (card1.rank == 4 && card2.name == "Ace") {
                return true
            } else {
                if (card1.name == "Ace" && card2.name != "Ace" ) {
                    return true
                } else if (card2.name == "Ace" && card1.name != "Ace") {
                    return false
                } else {
                    return false
                }
            }
        }
    } // end function
    
    func activate() -> Bool {
        
        // create loop to make sure war will only end when cards do not match
        repeat {
            
            // loop through opponent's turn 4 times, in order to draw card
            for _ in 1...4 {
                opponentTurn()
            }
            players[1].card = players[1].cards.last // reveal top card
            print("\(players[1].name)'s top card is the \(players[1].card!.name) of \(players[1].card!.suit)")
            // code is same as above, except for the active player
            for _ in 1...4 {
                playerTurn()
            }
            players[0].card = players[0].cards.last
            print("\(players[0].name)'s top card is the \(players[0].card!.name) of \(players[0].card!.suit)")
        } while (players[0].card!.rank == players[1].card!.rank && !compare(card1: players[0].card!, card2: players[1].card!))
        
        // determine winner and give them all the cards
        if (compare(card1: players[0].card!, card2: players[1].card!)) {
            players[0].discard.append(contentsOf: players[1].cards)
            players[0].discard.append(contentsOf: players[0].cards)
            players[1].card = nil
            players[1].cards.removeAll()
            players[0].card = nil
            players[0].cards.removeAll()
            return true
        } else {
            players[1].discard.append(contentsOf: players[0].cards)
            players[1].discard.append(contentsOf: players[1].cards)
            players[0].card = nil
            players[0].cards.removeAll()
            players[1].card = nil
            players[1].cards.removeAll()
            return false
        }
    } // end function
    
    // function for player turn
    func playerTurn() {
        var choice: Int
            
        repeat {
            choice = dialog.activate()
        } while (choice == 0)
        
        if (dialog.choices[choice-1] != dialog.choices[1]) {
            if (players[0].deck.count > 0) {
                let idx = players[0].deck.index(where: { $0.name == players[0].deck.first!.name && $0.suit == players[0].deck.first!.suit})
                players[0].cards.append(players[0].deck.first!)
                players[0].deck.remove(at: idx!)
                print("\(players[0].name) drew a card.")
            } else {
                if (players[0].discard.count > 0) {
                    players[0].deck.append(contentsOf: players[0].shuffle(supply: players[0].discard))
                    players[0].discard.removeAll()
                
                    let idx = players[0].deck.index(where: { $0.name == players[0].deck.first!.name && $0.suit == players[0].deck.first!.suit})
                    players[0].cards.append(players[0].deck.first!)
                    players[0].deck.remove(at: idx!)
                    print("\(players[0].name) drew a card.")
                }
            }
        } else {
            exit(0)
        }
    }
    
    // function for oppenent turn
    func opponentTurn() {
        if (players[1].deck.count > 0) {
            let idx = players[1].deck.index(where: { $0.name == players[1].deck.first!.name && $0.suit == players[1].deck.first!.suit})
            players[1].cards.append(players[1].deck.first!)
            players[1].deck.remove(at: idx!)
            print("\(players[1].name) drew a card.")
        } else {
            if (players[1].discard.count > 0) {
                players[1].deck.append(contentsOf: players[1].shuffle(supply: players[1].discard))
                players[1].discard.removeAll()
            
                let idx = players[1].deck.index(where: { $0.name == players[1].deck.first!.name && $0.suit == players[1].deck.first!.suit})
                players[1].cards.append(players[1].deck.first!)
                players[1].deck.remove(at: idx!)
                print("\(players[1].name) drew a card.")
            }
        }
    }
} // end class
