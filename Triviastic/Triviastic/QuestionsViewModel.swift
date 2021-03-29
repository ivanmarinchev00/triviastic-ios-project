//
//  QuestionsViewModel.swift
//  Triviastic
//
//  Created by Ivan Marinchev on 3/15/21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class QuestionsViewModel: ObservableObject{
    @Published var questions = [Question]()
    
    private var db = Firestore.firestore()
    
    var storage = FirebaseStorage.Storage.storage()
    
    
    
    func fetchData(){
        db.collection("questions").addSnapshotListener {(querySnapshot, error) in
            guard let questions = querySnapshot?.documents else {
                print("There was a problem")
                return
            }
            self.questions = questions.map { (queryDocumentSnapshot) -> Question in
                let data = queryDocumentSnapshot.data()
                
                
                let question = data["question"] as? String ?? ""
                let correctAnswer = data["answer1"] as? String ?? ""
                let answer2 = data["answer2"] as? String ?? ""
                let answer3 = data["answer3"] as? String ?? ""
                let answer4 = data["answer4"] as? String ?? ""
                let hint = data["hint"] as? String ?? ""
                let points = data["points"] as? Int ?? 0
                let questionId = queryDocumentSnapshot.documentID as? String ?? ""
                
                return Question(points: points, question: question, rightAnswer: correctAnswer, wAnswer1: answer2, wAnswer2: answer3, wAnswer3: answer4, hint: hint, questionId: questionId)
            }
        }
        
    }
    func downloadImage(url: String) -> Bool{
        var bool = false
        var actualUrl = "gs://triviastic.appspot.com/\(url)"
        let storage = Storage.storage().reference(withPath: actualUrl)
        storage.downloadURL { (urll, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            bool = true
            print("Download success")
            return
        }
        return bool
    }
}
