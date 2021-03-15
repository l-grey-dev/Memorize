//  beta2
//
//  EmojiMemoryGameView.swift
//  
//  Created by Sergey Lukaschuk on 14.01.2021.
//

import SwiftUI

// View

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
        .padding()
        .foregroundColor(Color.orange)
            
            Button {
                withAnimation(.easeInOut) {
                    viewModel.resetGame()
                }
            } label: { Text("New Game") }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360.0 : 0.0))
                    .animation(card.isMatched ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK:  Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
