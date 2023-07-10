//
//  ContentView.swift
//  Shifumi
//
//  Created by Arthur Beau on 07/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var playerSelection = "Pierre"
    @State private var computerScore = 0;
    @State private var playerScore = 0;
    @State private var finished = false;
    
    let choices = ["Pierre", "Feuille", "Ciseaux"]
    let computerWin = [
        "On vous a devancé...",
        "'Bip boup... J'ai gagné, humain.'",
        "#Predicted"
    ]
    let playerWin = [
        "1 point pour les humains !",
        "Quelle rapidité !",
        "Yes we did it!"
    ]
    
    var body: some View {
        ScrollView {
            Text("Score : \(playerScore) / \(computerScore)").font(.title)
            
            VStack {
                if (finished) {
                    Spacer().frame(height: 15)
                    if (computerScore == 3) {
                        Text("L'ordinateur a gagné, gloire aux machines !");
                    } else {
                        Text("Vous avez gagné ! ChatGPT n'a qu'à bien se tenir...");
                    }
                    
                    Spacer().frame(height: 15)
                    
                    Button("Quitter") {
                        exit(0)
                    }
                } else {
                    Spacer().frame(height: 15)
                    Picker("Que voulez-vous jouer ?", selection: $playerSelection) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Spacer().frame(height: 30)
                    
                    Button {
                        let alert = NSAlert()
                        let computerSelection = choices.randomElement()!
                        
                        if (computerSelection == "Pierre" && playerSelection == "Ciseaux" ||
                            computerSelection == "Feuille" && playerSelection == "Pierre" ||
                            computerSelection == "Ciseaux" && playerSelection == "Feuille") {
                            computerScore += 1
                            alert.messageText = computerWin.randomElement()!
                        } else {
                            playerScore += 1
                            alert.messageText = playerWin.randomElement()!
                        }
                        
                        alert.informativeText = "L'ordinateur a choisi : " + computerSelection
                        alert.alertStyle = .informational
                        alert.runModal()
                        
                        if (computerScore == 3 || playerScore == 3) {
                            finished = true;
                        }
                    } label: {
                        Text("Jouer")
                            .padding()
                    }
                    .cornerRadius(6.0)
                    .buttonStyle(.bordered)
                }
            }
        }
        .frame(width: 250, height: 125)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
