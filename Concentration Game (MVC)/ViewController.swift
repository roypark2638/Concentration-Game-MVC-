//
//  ViewController.swift
//  Concentration Game (MVC)
//
//  Created by Roy Park on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Flip Count: \(flipCount)" } }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var playAgainButton: UIButton!
        
    @IBOutlet weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
    }
    
    @IBAction func CardPressed(_ sender: UIButton) {
        
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            let gameStatus = game.isGameEned()
            if gameStatus == true {
                playAgainButton.isHidden = false
            }
        } else {
            print("chosen car was not in cardButtons")
        }
        
    }
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        game.resetGame()
        self.flipCount = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        playAgainButton.isHidden = true
        
    }
    
    func updateViewFromModel() {
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
    var emojiChoices = ["👾","💩","😈","👻","👽","🤡","🤠","👅","🦷","💋","👒"]
    func resetEmojises() {
        emojiChoices = ["👾","💩","😈","👻","👽","🤡","🤠","👅","🦷","💋","👒"]
    }
    
    var emoji = [Int:String]()
    func emoji(for card: Card) -> String {
        if game.isGameEned() { resetEmojises() }
        if emoji[card.identifier] == nil , emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        return emoji[card.identifier] ?? "?"
    }
}

