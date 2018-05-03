

import Foundation



struct PlayingCardModel {
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String {
        case spades = "♠️"
        case hearts = "♣️"
        case diamonds = "♥️"
        case clubs = "♦️"
        
        static var all: [PlayingCardModel.Suit] {
            return [Suit.spades,Suit.hearts,Suit.diamonds,Suit.clubs]
        }
        
    }
    
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var collection: [Rank] = [PlayingCardModel.Rank.ace]
            for pips in 2...10 {
                collection.append(Rank.numeric(pips))
            }
            collection += [Rank.face("J"),Rank.face("Q"),Rank.face("K")]
            return collection
        }
    }
}














