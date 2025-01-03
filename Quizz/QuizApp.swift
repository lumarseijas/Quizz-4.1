//
//  QuizzApp.swift
//  Quizz
//
//  Created by d121 DIT UPM on 25/11/24.
//

import SwiftUI

@main
struct QuizApp: App {
    @State var quizzesModel = QuizzesModel()
    @State var scoresModel = ScoresModel()
    @State var favoritos = Favoritos()
    var body: some Scene {
        WindowGroup {
            QuizzesView()
                .environment(quizzesModel)
                .environment(scoresModel)
                .environmentObject(favoritos)
        }
    }
}
