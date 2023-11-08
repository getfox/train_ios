//
//  ContentView.swift
//  train_ios
//
//  Created by 郭旭 on 2023/11/5.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😅", "🥹", "🤣", "🥳", "🥲", "🥰", "😇", "🤪", "🤩", "🤗", "🤠", "🤡" ,"😈"]
    @State var emoji_number: Int = 3
    var body: some View {
        
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            buttons
            
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120)), GridItem(.adaptive(minimum: 120)), GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<emoji_number, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(.orange)
    }
    
    var buttons : some View {
        HStack{
            
            button_remover
            Spacer()
            button_adder
            
            
        }
        .foregroundColor(.blue)
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            emoji_number += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(emoji_number + offset > emojis.count || emoji_number + offset < 1)
    }
    var button_remover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var button_adder : some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}




struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0: 1)
            
        }
        .onTapGesture{
            print("tapped.")
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
