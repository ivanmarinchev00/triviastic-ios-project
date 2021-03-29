//
//  AddQuestionView.swift
//  Triviastic
//
//  Created by Ivan Marinchev on 3/11/21.
//

import SwiftUI
import Firebase
import FirebaseStorage


struct AddQuestionView: View {
    @StateObject var q = QuestionToAdd()
    @State private var question = ""
    @State private var image: Image?
    @State private var isShowingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        GeometryReader{ geometry in
            
            NavigationView{
                
               
                    VStack{
//                        Button(action: {}, label: {
//                            Image(systemName: "chevron.backward.2")
//                                .font(.largeTitle)
//                                .foregroundColor(.black)
//                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.01, alignment: Alignment.topLeading )
//
//                                //.position(x: 50, y: 20)
//
//                        })
                        Group{
                            
                            
                            
                            Text("Question:")
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.02, alignment: .center)
                                .padding()
                                
                            
                            TextField("Type your question here", text: $q.question){_ in
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.02, alignment: .center)
                            .padding()
                            
        
                            
                            if image != nil{
                                image?
                                    .resizable()
                                    .scaledToFit()
                                    .onTapGesture {
                                        image = nil
                                    }
                            } else{
                                Text("Upload picture if necessary")
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                                    .padding()
                                
                                Button(action: {
                                    self.isShowingImagePicker = true
                                }, label: {
                                    Image(systemName: "square.and.arrow.up")
                                        
                                        .foregroundColor(.black)
                                        .frame(width: geometry.size.width * 0.2, height: geometry.size.height * 0.1, alignment: .center)
                                        .background(Color.secondary)
                                        
                                })
                                
                            }
                            
                            
                        }
                        Group{
                            Text("Correct answer:")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                                .padding()
                            
                            TextField("Type the correct answer here", text: $q.answer1){_ in
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                            
                            
                            Text("Wrong answer:")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                                .padding()
                            
                            TextField("Type here", text: $q.answer2){_ in
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                            
                            
                            Text("Wrong answer:")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                                
                            
                            TextField("Type here", text: $q.answer3){_ in
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                            
                            
                            Text("Wrong answer:")
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.02, alignment: .center)
                                .padding()
                            
                            TextField("Type here", text: $q.answer4){_ in
                                
                                
                            }
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.01, alignment: .center)
                            

                            Button("Suggest") {
                                addQuestion(q: q,image: inputImage)
                            }
                                    .cornerRadius(3.0)
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.1, alignment: .center)
                                    .background(Color.gray)
                                    
                                
                            
                        }
                        
                    
                }
                    .navigationBarHidden(true)
            }
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage){
            ImagePicker(image : self.$inputImage)
        }
       
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
    
}

struct AddQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionView()
    }
}


func uploadImage(image: UIImage?, name: String){
    guard let image = image else {
               return
           }
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage = Storage.storage()
        storage.reference().child(name).putData(imageData, metadata: nil){
            (_,err) in
            if let err = err{
                print(err.localizedDescription)
            }
            else{
                print("success")
            }
        }
    }
}


func addQuestion(q: QuestionToAdd, image: UIImage?){

//    let jsonData = try! JSONEncoder().encode(q)
//    let jsonString = String(data: jsonData, encoding: .utf8)!
//    print(jsonString)
    let db = Firestore.firestore()
    //let data = q
    

    let data: [String: Any] = [

        "question": q.question,
        "answer1": q.answer1,
        "answer2": q.answer2,
        "answer3": q.answer3,
        "answer4": q.answer4
        

    ]
    
    
    do {
        var ref: DocumentReference? = nil
        try ref = db.collection("questions").addDocument(data: data)
        print(ref!.documentID)
        uploadImage(image: image, name: ref!.documentID)
    } catch let error {
        print("Error writing city to Firestore: \(error)")
    }


    
    }
