//
//  ExpandCellBootcamp.swift
//  SwiftUIComponents
//
//  Created by Philophobic on 29/12/24.
//

import SwiftUI

struct LanguageModel: Identifiable {
    var id = UUID().uuidString
    let title: String
    let description: String
}

class LanguageViewModel: ObservableObject {
    @Published var languages: [LanguageModel] = []
    
    init() {
        getDataForModel()
    }
    
    func getDataForModel() {
        let programmingLanguages = [
            LanguageModel(
                title: "Swift",
                description: "Swift is a powerful and intuitive programming language for iOS, macOS, watchOS, and tvOS app development. It is designed to work seamlessly with Objective-C and offers modern features like safety and performance."
            ),
            LanguageModel(
                title: "Python",
                description: "Python is a high-level, interpreted language known for its simplicity and readability. It is widely used for web development, data science, machine learning, automation, and scripting."
            ),
            LanguageModel(
                title: "JavaScript",
                description: "JavaScript is a versatile language used primarily for interactive web development. It allows developers to create dynamic web pages and is essential for front-end development."
            ),
            LanguageModel(
                title: "Java",
                description: "Java is a versatile and platform-independent language commonly used for enterprise-level applications, Android development, and backend systems. It follows the principle of 'write once, run anywhere.'"
            ),
            LanguageModel(
                title: "C++",
                description: "C++ is a powerful, high-performance programming language often used for system software, game development, and applications requiring real-time processing. It extends the capabilities of the C language with object-oriented features."
            )
        ]
        languages = programmingLanguages
    }
}

struct ExpandCellBootcamp: View {
    @StateObject private var viewModel = LanguageViewModel()
    @State private var expandedLanguages: Set<String> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.languages) { language in
                    LanguageRow(
                        language: language,
                        isExpanded: expandedLanguages.contains(language.id),
                        onTap: { toggleExpansion(for: language.id) }
                    )
                }
            }
            .padding()
        }
    }
    
    private func toggleExpansion(for id: String) {
        withAnimation {
            if expandedLanguages.contains(id) {
                expandedLanguages.remove(id)
            } else {
                expandedLanguages.insert(id)
            }
        }
    }
}

// MARK: - LanguageRow
struct LanguageRow: View {
    let language: LanguageModel
    let isExpanded: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: onTap) {
                HStack {
                    Text(language.title)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.vertical, 15)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.up")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                .padding(.horizontal)
            }
            
            if isExpanded {
                Text(language.description)
                    .font(.subheadline)
                    .padding()
                    .transition(.opacity.combined(with: .slide)) // Smooth transition
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

// MARK: - Preview
#Preview {
    ExpandCellBootcamp()
}

