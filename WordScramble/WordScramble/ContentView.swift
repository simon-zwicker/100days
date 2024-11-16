//
//  ContentView.swift
//  WordScramble
//
//  Created by Simon Zwicker on 14.11.24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var usedWords: [String] = .init()
    @State private var rootWord: String = .init()
    @State private var newWord: String = .init()
    @State private var errorTitle: String = .init()
    @State private var errorMessage: String = .init()
    @State private var showingError: Bool = false
    @State private var showWordError: Bool = false
    @State private var score: Int = 0
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Score: \(score)")
                        .font(.subheadline.bold())
                }
                
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                    if showWordError {
                        Text("Word should be longer than 3 Characters")
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                if newWord.count > 3 {
                    showWordError = false
                    addNewWord()
                } else {
                    newWord = ""
                    showWordError = true
                }
            }
            .onAppear {
                startGame()
            }
            .alert(errorTitle, isPresented: $showingError) {} message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Give me a other word") {
                        startGame()
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(answer) else {
            wordError("Word used already", "Be more original")
            return
        }

        guard isPossible(answer) else {
            wordError("Word not possible", "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(answer) else {
            wordError("Word not recognized", "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += newWord.count
        newWord = ""
    }
    
    private func startGame() {
        guard
            let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsUrl, encoding: .utf8)
        else { fatalError("Could not load start.txt from bundle.") }
        
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
        usedWords = .init()
    }
    
    private func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isReal(_ word: String) -> Bool {
        let checker: UITextChecker = .init()
        let range: NSRange = .init(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        
        for char in word {
            guard let position = tempWord.firstIndex(of: char) else { return false }
            tempWord.remove(at: position)
        }
        
        return true
    }
    
    private func wordError(_ title: String, _ message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
