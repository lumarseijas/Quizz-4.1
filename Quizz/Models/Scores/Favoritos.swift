//
//  Favoritos.swift
//  Quizz
//
//  Created by d121 DIT UPM on 28/11/24.
//

import Foundation
class Favoritos: ObservableObject {
    @Published var listaFav: [Int: Bool] = [:] // Diccionario de favoritos (quiz ID -> estado favorito)

    func toggleFavourite(for quizID: Int) {
        // Cambia el estado de favorito del quiz
        if let actual = listaFav[quizID] {
            listaFav[quizID] = !actual
        } else {
            listaFav[quizID] = true // Si no existe, lo marca como favorito
        }
    }
    
    func isFavourite(_ quizID: Int) -> Bool {
        return listaFav[quizID] ?? false
    }
}
