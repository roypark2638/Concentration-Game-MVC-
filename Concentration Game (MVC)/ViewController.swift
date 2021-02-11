//
//  ViewController.swift
//  Concentration Game (MVC)
//
//  Created by Roy Park on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    private(set) var flipCount = 0 { didSet { flipCountLabel.text = "Flip Count: \(flipCount)" } }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var playAgainButton: UIButton!
        
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
    }
    
    @IBAction private func CardPressed(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if !game.cards[cardNumber].isMatched {
                flipCount += 1
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            let gameStatus = game.isGameEnded()
            if gameStatus == true {
                playAgainButton.isHidden = false
            }
        } else {
            print("chosen car was not in cardButtons")
        }
        
    }
    
    @IBAction private func playAgainPressed(_ sender: UIButton) {
        game.resetGame()
        self.flipCount = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        playAgainButton.isHidden = true
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 0.1960974932, green: 0.5739633441, blue: 0, alpha: 0) : #colorLiteral(red: 0.1960974932, green: 0.5739633441, blue: 0, alpha: 1)
            }
        }
    }
    private var emojiChoices = ["👾","💩","😈","👻","👽","🤡","🤠","👅","🦷","💋","👒"]
    private func resetEmojises() {
        emojiChoices = ["👾","💩","😈","👻","👽","🤡","🤠","👅","🦷","💋","👒"]
    }
    
    private var emoji = [Card:String]()
    private func emoji(for card: Card) -> String {
        if game.isGameEnded() { resetEmojises() }
        
        if emoji[card] == nil , emojiChoices.count > 0 {
            let emojiIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.acr4random)
            emoji[card] = emojiChoices.remove(at: emojiIndex)
            }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var acr4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

