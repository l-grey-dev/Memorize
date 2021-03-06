//  Master 😎😎
//
//  EmojiMemoryGame.swift
//
//  Created by Sergey Lukaschuk on 15.01.2021.
//

import Foundation


// ViewModel

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷", "😈"]
        return MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}












