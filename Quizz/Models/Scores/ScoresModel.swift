//
//  ScoresModel.swift
//  Quizz
//
//  Created by d121 DIT UPM on 25/11/24.
//

import Foundation
@Observable class ScoresModel {
    private(set) var acertados: Set<Int> = []
    
    func meter(quizItem: QuizItem, respuesta: String) {
        if respuesta.lowercased() == quizItem.answer.lowercased() {
            acertados.insert(quizItem.id)
        }
    }
}
