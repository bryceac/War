// Card struct holds card data
struct Card: Codable {
    let name: String, rank: Int, suit: String
}

struct CardList: Codable {
    let cards: [Card]
}
