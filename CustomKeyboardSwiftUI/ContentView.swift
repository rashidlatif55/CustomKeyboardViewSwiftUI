//
//  ContentView.swift
//  CustomKeyboardSwiftUI
//
//  Created by Rashid Latif on 29/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: String = ""
    @FocusState private var isKeyboardShowing:Bool
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("0.00 AED",text: $amount)
                    .inputKeyboardView(content: {
                        PaymentKeyboardView { key in
                            handleKeyPress(key: key)
                        }
                    })
                    .focused($isKeyboardShowing)
                    .multilineTextAlignment(.center)
                    .font(.title).bold()
                
            }
            .padding()
        }
    }
    
    private func handleKeyPress(key: String) {
        switch key {
        case "⌫":
            if amount == "0." {
                amount = ""
            } else if !amount.isEmpty {
                amount.removeLast()
            }
            
        case "Done":
            
            if amount.hasSuffix(".") {
                amount.append("0") // if the last character is ".", append 0 so it will look like "123.0" not like "123."
            }
            self.isKeyboardShowing.toggle()
        case ".":
            if !amount.contains(".") {
                if amount.isEmpty {
                    amount = "0."
                } else {
                    amount.append(".")
                }
            }
            
        default:
            amount.append(key)
        }
    }
    
}

#Preview {
    ContentView()
}

struct PaymentKeyboardView: View {
    var onKeyPress: (String) -> Void
    
    let keys: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"],
        ["Done"]
    ]
    
    var body: some View {
        VStack {
            ForEach(keys, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { key in
                        
                        Button(action: {
                            onKeyPress(key)
                        }) {
                            Text(key)
                                .font(.body).bold()
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
