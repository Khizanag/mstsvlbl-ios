//
//  ContentView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
 

struct ContentView: View {
    @StateObject private var viewModel = QuizViewModel()

    var body: some View {
        QuizListView()
    }
}

#Preview {
    ContentView()
}

