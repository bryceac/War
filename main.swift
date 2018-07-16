let assets = Assets()
let cards = assets.shuffled(supply: assets.cards)

let opponents: [Character] = [Character(name: "Henry"), Character(name: "Marcus"), Character(name: "Alexander"), Character(name: "Akira")]

var name: String? // variable to hold name of player
repeat {
    print("Enter Name: ")
    name = readLine()
} while (name!.count == 0)

var player = Character(name: name!) // create a player object

var opponent = opponents[RandomGen(number: opponents.count)] // randomly pick opponent

let dealer = RandomGen(number: 2) // generate a random number between 0 and 1 in a way that works on different platforms

// determine who deals cards
if (dealer == 0) {
    print("\(player.name) deals out cards")
    player.deal(player: opponent, supply: cards)
} else {
    print("\(opponent.name) deals out cards")
    opponent.deal(player: player, supply: cards)
}

let war = War(player: player, opponent: opponent) // create war object

while (player.isAlive() && opponent.isAlive())
{
    print ("\(player.name)'s Deck: \(player.deck.count)\r\n\r\n")
    print("\(player.name)'s Discard: \(player.discard.count)\r\n\r\n")

    print ("\(opponent.name)'s Deck: \(opponent.deck.count)\r\n\r\n")
    print("\(opponent.name)'s Discard: \(opponent.discard.count)\r\n\r\n")
    
    war.opponentTurn()
    war.playerTurn()
    
    player.card = player.cards.last!
    opponent.card = opponent.cards.last!
    
    print("\(player.name)'s topmost Card: \(player.card?.name ?? "Nothing") of \(player.card?.suit ?? "No Suit")\r\n\r\n")
    print("\(opponent.name)'s topmost Card: \(opponent.card?.name ?? "Nothing") of \(opponent.card?.suit ?? "No Suit")\r\n\r\n")
    
    // if cards match, initiate war
    if (!war.compare(card1: player.card!, card2: opponent.card!) && player.card!.rank == opponent.card!.rank){
        if (war.activate()) {
            print("you won the war!")
        } else {
            print("you lost the war.")
        }
    } else if (!war.compare(card1: player.card!, card2: opponent.card!)) {
         print("\(opponent.name) stole your card")
        opponent.discard.append(contentsOf: opponent.cards)
        opponent.card = nil
        opponent.cards.removeAll()
        opponent.discard.append(contentsOf: player.cards)
        player.card = nil
        player.cards.removeAll()
    } else {
        print("congratulations on stealing \(opponent.name)'s card")
        player.discard.append(contentsOf: opponent.cards)
        opponent.card = nil
        opponent.cards.removeAll()
        player.discard.append(contentsOf: player.cards)
        player.card = nil
        player.cards.removeAll()
    }
} // end game loop

if (!player.isAlive()) {
    print("You lose!")
} else {
    print("Congratulations, you win!")
}
