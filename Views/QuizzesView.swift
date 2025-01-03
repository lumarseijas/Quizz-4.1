//
//  QuizzesView.swift
//  Quiz
//
//  Created by d121 DIT UPM on 25/11/24.
//


import SwiftUI


struct QuizzesView: View{
    //var quizzesModel: QuizzesModel
    @Environment(ScoresModel.self) var scoresModel: ScoresModel
    @Environment(QuizzesModel.self) var quizzesModel: QuizzesModel
    @EnvironmentObject var favoritos: Favoritos
    
    //@EnvironmentObject var quizzesModel: QuizzesModel
    var body: some View{
        NavigationStack{
            //Image("qm")
            //Text("score: \(scoresModel.acertados.count)")
            List {
                ForEach(quizzesModel.quizzes) {quizItem in
                    NavigationLink (destination:QuizPlayView(quizItem: quizItem)){
                        QuizRowView(quizItem: quizItem, isFavourite: favoritos.isFavourite(quizItem.id))
                    }
                    Button(action: {
                        favoritos.toggleFavourite(for: quizItem.id)
                    }) {
                        Image(systemName: favoritos.isFavourite(quizItem.id) ? "syellow" : "sgrey")}
                    
                }
            }
            
            .listStyle(.plain)
            .navigationTitle("Quizzes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Score: \(scoresModel.acertados.count)")
                        .font(.headline)
                    //.bold()
                    
                }
            }
        
        }
        
    
        .padding()
        .onAppear {
            print("estoy cargando los datos")
            if quizzesModel.quizzes.count==0{
                quizzesModel.load() //lo carga la 1 vez que aparezca eso
            }
        }
        
        
    }
}

#Preview{
    @Previewable @State var model = QuizzesModel()
    @Previewable @State var scoresModel = ScoresModel()
    @Previewable @State var favoritos = Favoritos()

    QuizzesView()
        .environment(model)
        .environment(scoresModel)
        .environmentObject(favoritos)
    
}
