//
//  GamePageView.swift
//  Triviastic
//
//  Created by Ivan Marinchev on 3/9/21.
//

import SwiftUI
import Firebase

struct GamePageView: View {
    
    @State private var rnd = Int.random(in: 0..<4)
    
    @ObservedObject private var viewModel = QuestionsViewModel()
    
    @State private var imageUrl = "gs://triviastic.appspot.com/Epvsu3J7sPW0ci9mxwqu"
    
//    @State private var arrayAnswers = [QuestionsViewModel().questions.first?.rightAnswer ?? "", QuestionsViewModel().questions.first?.wAnswer1 ?? "", QuestionsViewModel().questions.first?.wAnswer2 ?? "", QuestionsViewModel().questions.first?.wAnswer3 ?? ""].shuffled()
    
    @State private var question = "A randomly generated question"
    
    
    @State private var showingHint = false
    @State var image:String
    
    let questionMark = UIImage(systemName: "questionmark.circle")

    
    var body: some View {
        let arrayAnswers = [viewModel.questions.first?.rightAnswer ?? "No More Questions Left", viewModel.questions.first?.wAnswer1 ?? "No More Questions Left", viewModel.questions.first?.wAnswer2 ?? "No More Questions Left", viewModel.questions.first?.wAnswer3 ?? "No More Questions Left"].shuffled()
        GeometryReader{ geometry in
            
            LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            
            VStack{

                HStack(){
                    //                    Button(action: {}, label: {
                    //                        Image(systemName: "chevron.backward.2")
                    //                            .font(.largeTitle)
                    //                            .foregroundColor(.black)
                    //                            .frame(width: geometry.size.width * 0.85, height: 40, alignment: Alignment.topLeading )
                    //                            //.position(x: 50, y: 20)
                    //
                    //                    })
                   
                    
//                    Button(action: {
//                        self.showingHint.toggle()
//                    }, label: {
//                        Image(systemName: "questionmark.circle")
//                            .font(.largeTitle)
//                            .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05, alignment: Alignment.topTrailing) .foregroundColor(.black)
//                    })
                }
//                .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.05, alignment: Alignment.topTrailing)
                
                
                
                
                Text(viewModel.questions.first?.question ?? "")
                    .frame(width: geometry.size.width * 0.70, height: 70)
                    .padding()
                
                if image != nil{
                    Image("\(image)")
                        .frame(width: geometry.size.width * 0.70, height: geometry.size.height * 0.2)
                } else {
                    Image("TriviasticLogo")
                        .frame(width: geometry.size.width * 0.70, height: geometry.size.height * 0.2)
                }
                
                
                
                Button(arrayAnswers[1]) {
                    answerQuestion(answer: arrayAnswers[1])
                }
                .foregroundColor(.white)
                .frame(width: geometry.size.width * 0.70, height: geometry.size.height * 0.04, alignment: Alignment.center)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                
                
                Button(arrayAnswers[0]) {
                    answerQuestion(answer: arrayAnswers[0])
                    print("HEREEEE\(viewModel.questions.first?.questionId ?? "")")
                }
                .foregroundColor(.white)
                .frame(width: geometry.size.width * 0.70, height: geometry.size.height * 0.04)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                
                Button(arrayAnswers[3]) {
                    answerQuestion(answer: arrayAnswers[3])
                }
                .foregroundColor(.white)
                .frame(width: geometry.size.width * 0.70, height: geometry.size.height * 0.04)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                
                Button(arrayAnswers[2]) {
                    answerQuestion(answer: arrayAnswers[2])
                }
                .foregroundColor(.white)
                .frame(width: geometry.size.width * 0.70, height: geometry.size.height * 0.04)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                .padding()
                
                
                
                .alert(isPresented: $showingHint){
                    Alert(title: Text("Hint"), message: Text("This is the hint"))
                }
                
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.largeTitle)
                            .frame(width: geometry.size.width * 0.10, height: geometry.size.height * 0.04, alignment: Alignment.leading)                        .foregroundColor(.black)
                    })
                    
                    Button(action: {}, label: {
                        Image(systemName: "hand.thumbsdown.fill")
                            .font(.largeTitle)
                            .frame(width: geometry.size.width * 0.80, height: geometry.size.height * 0.04, alignment: Alignment.trailing)
                            .foregroundColor(.black)
                    })
                }
                
                
            }
            .frame(width: geometry.size.width * 1, height: geometry.size.height * 1, alignment: .center)
            
        }
        .onAppear(){
            self.viewModel.fetchData()
            self.viewModel.questions.shuffle()
            var imagePresent = self.viewModel.downloadImage(url: viewModel.questions.first?.questionId ?? "")
            if(imagePresent == true){
                self.image = "gs://triviastic.appspot.com/\(viewModel.questions.first?.questionId ?? "")"
            }
        }
        
       
    }
    func answerQuestion(answer: String){
//        UserDefaults.standard.setValue("qGWIhCfmTTeRSOeN8A3vDqDRWDs2", forKey: "uuid")
        if(viewModel.questions.first?.rightAnswer == answer){
            //user gets added points
            print("Correct asnwer")
            var uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
            modifyPoints(
                uuid, viewModel.questions.first!.points)
            viewModel.questions.remove(at: 0)
            
        } else{
            print("Wrong answer")
            viewModel.questions.remove(at: 0)
            var uuid = UserDefaults.standard.string(forKey: "uuid") ?? ""
            modifyPoints(
                uuid, -(viewModel.questions.first!.points / 2))
            vibrate()
        }
        
    }
    
    func vibrate(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}


struct GamePageView_Previews: PreviewProvider {
    static var previews: some View {
        GamePageView(image: "")
    }
}

func modifyPoints(_ uuid: String,_ pointsToAdd: Int ) {
    let db = Firestore.firestore()
    var oldPoints = 0
    
    db.collection("users").document(uuid).getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
            let data = document.data()

           oldPoints = data!["points"]! as? Int ?? 0
            print("old")
            print(oldPoints)
            
            print(pointsToAdd)
            
            var newPoints = pointsToAdd + oldPoints
            print("new")
            print(newPoints)
            
            let userRef = db.collection("users").document(uuid)

            
            userRef.updateData([
                "points": newPoints
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }

        } else {
            print("Document does not exist")
        }
    }
    
   
}



