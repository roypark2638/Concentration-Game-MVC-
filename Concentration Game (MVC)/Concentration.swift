//
//  Concentration.swift
//  Concentration Game (MVC)
//
//  Created by Roy Park on 11/25/20.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    // when both of cards are face up or face down then this var will be nil
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // check if the cards are matched and they are not the same position card
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // check if cards matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    func resetGame() {
        for cardIndex in cards.indices {
            cards[cardIndex].isFaceUp = false
        }
    }
    
    func isGameEned() -> Bool{
        for cardIndex in cards.indices {
            if cards[cardIndex].isMatched == false {
                return false
            }
        }
        return true
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}


