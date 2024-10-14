//
//  ContentView.swift
//  LanguageDetectionApp
//
//  Created by Caio Montilha on 10/14/24.
//  LanguageDetectionApp is licensed under the MIT License

// Import necessary libraries
import SwiftUI
import NaturalLanguage

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var detectedLanguage: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Welcome to Language Detection App")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 10)
            
            Text("Enter text here:")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
            
            TextEditor(text: $inputText)
                .frame(height: 100)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
            
            Button(action: {
                detectedLanguage = detectLanguage(for: inputText)
            }) {
                Text("Detect Language")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
            
            if !detectedLanguage.isEmpty {
                Text("Detected Language: \(detectedLanguage)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
    }
    
    func detectLanguage(for text: String) -> String {
        guard !text.isEmpty else { return "" }
        
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        
        if let languageCode = languageRecognizer.dominantLanguage?.rawValue {
            let locale = Locale.current
            return locale.localizedString(forLanguageCode: languageCode) ?? "Unknown Language"
        } else {
            return "Language Not Detected"
        }
    }
}

