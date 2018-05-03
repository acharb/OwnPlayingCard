import Foundation



struct PlayingCardDeckModel {
    
    var cards: [PlayingCardModel] = []
    
    init() {
        for suit in PlayingCardModel.Suit.all {
            for rank in PlayingCardModel.Rank.all {
                cards.append(PlayingCardModel(suit: suit, rank: rank))
            }
        }
    }
    
    
    mutating func draw() -> PlayingCardModel? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.randomize)
        }
        return nil
    }
}



extension Int {
    var randomize: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
