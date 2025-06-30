//
//MIT License
//
//Copyright © 2025 Cong Le
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//
//
//  ConsciousnessProblemsView.swift
//  ITT_Consciousness_Problems
//
//  Created by Cong Le on 6/29/25.
//

import SwiftUI

// MARK: - Data Models

/// Represents a single bibliographic reference.
/// Conforms to `Identifiable` and `Hashable` for use in SwiftUI lists.
struct Reference: Identifiable, Hashable {
    let id = UUID()
    let fullCitation: String
}

/// A structure to hold the details for one of the two problems of consciousness.
/// This model separates the conceptual data from the view's presentation logic.
struct ProblemDetail: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let accentColor: Color
    let coreQuestion: String
    let examples: [String]
    let solution: String
    let solutionDetail: String
}

// MARK: - UI Constants

/// A centralized place for styling constants to ensure a consistent UI.
struct UIConstants {
    static let quantityColor = Color(red: 0.2, green: 0.6, blue: 0.8) // A cool, analytical blue
    static let qualityColor = Color(red: 0.8, green: 0.3, blue: 0.5)  // A rich, phenomenological magenta
    static let cardPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 15
    static let shadowRadius: CGFloat = 5
}

// MARK: - Main SwiftUI View

/// A SwiftUI view that explains the two fundamental problems of consciousness
/// as defined by the Information Integration Theory (IIT).
///
/// This view is designed to be educational, presenting complex scientific concepts
/// in a clear, structured, and visually appealing format. It breaks down each problem
//*   into its core question, provides illustrative examples, and presents the
//*   theory's proposed solution.
struct ConsciousnessProblemsView: View {
    
    // MARK: - Data Source
    
    /// An array containing the details for both problems of consciousness.
    /// This data-driven approach allows the view to be easily updated or expanded.
    private let problemsData: [ProblemDetail] = [
        ProblemDetail(
            title: "The First Problem: Quantity",
            iconName: "scalemass.fill",
            accentColor: UIConstants.quantityColor,
            coreQuestion: "What determines the *level* or *amount* of consciousness a system possesses?",
            examples: [
                "Why are we fully conscious during wakefulness but much less so, or not at all, in dreamless sleep?",
                "Why does the highly complex thalamocortical system generate consciousness, while the cerebellum—with even more neurons—does not contribute directly to it?"
            ],
            solution: "The Capacity for Information Integration (Φ)",
            solutionDetail: "IIT proposes that the quantity of consciousness is measured by Φ (Phi), a value representing the amount of information a system can integrate as a unified whole. A high Φ value is associated with a high level of consciousness."
        ),
        ProblemDetail(
            title: "The Second Problem: Quality",
            iconName: "paintpalette.fill",
            accentColor: UIConstants.qualityColor,
            coreQuestion: "What determines the specific *kind* or *character* of a conscious experience?",
            examples: [
                "Why does seeing the color 'red' feel the way it does, and why is that experience fundamentally different from hearing a 'trumpet'?",
                "What gives each sensory modality—vision, audition, touch, pain—its unique and seemingly irreducible quality (quale)?"
            ],
            solution: "The Structure of Informational Relationships",
            solutionDetail: "The theory claims the quality of any experience is determined by the geometric shape of its 'qualia space.' This space is defined by the complete set of causal relationships (the Effective Information Matrix) among the elements of the conscious system."
        )
    ]
    
    /// A list of academic references in the Chicago Manual of Style format.
    private let references: [Reference] = [
        Reference(fullCitation: "Tononi, Giulio. 2004. “An Information Integration Theory of Consciousness.” BMC Neuroscience 5 (1): 42. https://doi.org/10.1186/1471-2202-5-42."),
        Reference(fullCitation: "Tononi, Giulio, and Gerald M. Edelman. 1998. “Consciousness and Complexity.” Science 282 (5395): 1846–51. https://doi.org/10.1126/science.282.5395.1846.")
    ]
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    
                    // --- Introduction ---
                    VStack(alignment: .leading, spacing: 8) {
                        Text("The Two Problems of Consciousness")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("The Information Integration Theory (IIT) frames the scientific study of consciousness by dissecting it into two core, solvable questions.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // --- Problem Cards ---
                    // Iterates through the data model to create a card for each problem.
                    ForEach(problemsData) { problem in
                        ProblemCardView(detail: problem)
                    }
                    
                    // --- References Section ---
                    VStack(alignment: .leading, spacing: 10) {
                        Text("References")
                            .font(.headline)
                            .padding(.top)
                        
                        ForEach(references) { reference in
                            Text(reference.fullCitation)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 5)
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.vertical)
            }
            .navigationTitle("Consciousness & IIT")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Reusable Component View

/// A view that displays the details of a single "problem of consciousness" in a card format.
/// This component is reusable and configured by the `ProblemDetail` data model.
struct ProblemCardView: View {
    
    let detail: ProblemDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // --- Card Header ---
            HStack {
                Image(systemName: detail.iconName)
                    .font(.title)
                    .foregroundColor(detail.accentColor)
                Text(detail.title)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            
            // --- Core Question ---
            Text(detail.coreQuestion)
                .font(.headline)
                .italic()
                .foregroundColor(.primary)
            
            Divider()
            
            // --- Examples Section ---
            VStack(alignment: .leading, spacing: 8) {
                Text("Key Examples:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                // Unpacks and lists the examples from the data model.
                ForEach(detail.examples, id: \.self) { example in
                    HStack(alignment: .top) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(detail.accentColor)
                            .padding(.top, 6)
                        Text(example)
                            .font(.body)
                    }
                }
            }
            
            Divider()
            
            // --- Solution Section ---
            VStack(alignment: .leading, spacing: 8) {
                Text("IIT's Proposed Solution:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
                Text(detail.solution)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(detail.accentColor)
                
                Text(detail.solutionDetail)
                    .font(.body)
            }
        }
        .padding(UIConstants.cardPadding)
        // Card-like appearance with background, corner radius, and shadow.
        .background(Color(.systemGray6))
        .cornerRadius(UIConstants.cornerRadius)
        .shadow(color: .black.opacity(0.1), radius: UIConstants.shadowRadius, x: 0, y: 2)
        .padding(.horizontal)
    }
}

// MARK: - SwiftUI Preview

/// Provides a preview of the view in Xcode, allowing for rapid UI development.
struct ConsciousnessProblemsView_Previews: PreviewProvider {
    static var previews: some View {
        ConsciousnessProblemsView()
    }
}
