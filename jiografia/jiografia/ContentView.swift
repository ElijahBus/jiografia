//
//  ContentView.swift
//  jiografia
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State var countries = DataLoader().countries
    @State var correctAnswer = 0
    @State var answeredQuestions = 0
    @State var score = 0
    @State var showScoreAlert = false
    @State var navigationTitle: String = ""
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                Text("Your score is: \(score)")
                Text(navigationTitle)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
            }
            .padding(.horizontal, 5)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(Color(.systemBackground))
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            Spacer()
            GridStack(rows: 2, columns: 2) { (row, column) in
                let index = indexAt(row, column)
                Button(action: {
                    buttonTapped(index)
                }) {
                    Text("\(countries[index].emoji)")
                }
                .font(.system(size: 160))
                .minimumScaleFactor(0.1)
                .background(Color.red)
            }
            Spacer()
            
        }
        .background(Color(.label).edgesIgnoringSafeArea(.vertical))
        .alert(isPresented: $showScoreAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue"), action: askQuestion))
        }
        .onAppear(perform: askQuestion)
    }
    
    private func indexAt(_ row: Int, _ column: Int) -> Int {
        return  row * 2 + column
    }
    
    private func buttonTapped(_ index: Int) {
        answeredQuestions += 1
        if index == correctAnswer {
            alertTitle = "Correct"
            score += 10
            alertMessage = "Your score is \(score)."
        } else {
            alertTitle = "Wrong"
            score -= 10
            alertMessage = "Wrong! That’s the flag of \(countries[index].name)."
        }
        let isfinal = answeredQuestions % 10 == 0
        alertMessage = isfinal ? "Your final score is \(score)." : alertMessage
        showScoreAlert.toggle()
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        navigationTitle =  "Find: " + countries[correctAnswer].name.uppercased()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

