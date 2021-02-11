//
//  Concentration.swift
//  Concentration Game (MVC)
//
//  Created by Roy Park on 11/25/20.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
    // when both of cards are face up or face down then this var will be nil
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) L Choosen index out of range")
        
        if !cards[index].isMatched {
            // check if the cards are matched and they are not the same position card
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // check if cards matched
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            } else {
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    func resetGame() {
        for cardIndex in cards.indices {
            cards[cardIndex].isFaceUp = false
        }
    }
    
    func isGameEnded() -> Bool{
        for cardIndex in cards.indices {
            if cards[cardIndex].isMatched == false {
                return false
            }
        }
        return true
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of the cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
