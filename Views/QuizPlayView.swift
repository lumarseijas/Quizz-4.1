//
//  File.swift
//  Quiz
//
//  Created by d121 DIT UPM on 25/11/24.
//
//

import SwiftUI
struct QuizPlayView: View{
    @Environment(ScoresModel.self) var scoresModel
    //@Environment(\.horizontalSizeClass) var hsc
    @Environment(\.verticalSizeClass) var vsc
    @State var showAlert: Bool = false
    @State var respuesta: String = ""
    @EnvironmentObject var favoritos: Favoritos

   
    var quizItem: QuizItem
    
    
    var body:some View{
        
        if vsc != .compact{
            
            VStack(alignment: .center) {
                cabecera
                respuestaView
                attachment
                autor
            }
        }else{
            VStack{
                cabecera
                HStack(alignment: .center){
                    VStack{
                        respuestaView
                        autor
                    }
                    attachment
                    
                }
            
            }
        }
    }
        
    var respuestaView: some View{
        VStack{
            TextField("Respuesta",text: $respuesta)
                .onSubmit{
                    showAlert = true
                    scoresModel.meter(quizItem: quizItem, respuesta: respuesta)
                }
            
                .alert(checkAnswer() ? "Correcto!" : "Mal", isPresented: $showAlert){               }
                .textFieldStyle(.roundedBorder)
            Button("Comprobar"){
                showAlert = true
                scoresModel.meter(quizItem: quizItem, respuesta: respuesta)
                
            }
        }
    }
     
    func checkAnswer()->Bool{
        respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        //respuesta == quizItem.answer //proe pone =+-=
        
        
    }
    
    
    
    var cabecera: some View{
        HStack{
            //pregunta
            Text(quizItem.question)
                .lineLimit(3)
                .font(.largeTitle)
                .bold()
                .font(.custom("Comic Sans MS", size: 24))
                .foregroundColor(.purple)
            //estrella
            //Image(quizItem.favourite ? "syellow" : "sgrey")
            Image(favoritos.isFavourite(quizItem.id) ? "syellow" : "sgrey")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                favoritos.toggleFavourite(for: quizItem.id)
                            }
                    }
                }
    
    var attachment: some View{
        let attachmentUrl = self.quizItem.attachment?.url
        
        return GeometryReader{ geometry in
            EasyAsyncImage(url: attachmentUrl)
                .frame(width: geometry.size.width, height:geometry.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 19))
                .overlay {
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color.black, lineWidth: 4)
                }
                .saturation(self.showAlert ? 0 : 1)
                .animation(.easeInOut, value: self.showAlert)
            
            
        }
        .padding()
    }
 
    
    var autor: some View {
        VStack(alignment: .trailing) {
            HStack{
                Spacer()
                Text(quizItem.author?.username ?? quizItem.author?
                    .profileName ?? "Anónimo")
                EasyAsyncImage(url: quizItem.author?.photo?.url)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Color.brown, lineWidth: 1)
                    }
            }
        }
    }
    
}
#Preview {
    @Previewable @State var quizzesModel = QuizzesModel()
    @Previewable @State var scoresModel = ScoresModel()
    @Previewable @StateObject var favoritos = Favoritos()
    
    let _ = quizzesModel.load()
    
    QuizPlayView(quizItem: quizzesModel.quizzes[14])
        .environment(scoresModel)
        .environmentObject(favoritos)
}

