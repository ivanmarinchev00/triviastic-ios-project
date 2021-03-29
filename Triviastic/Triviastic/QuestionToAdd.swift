//
//  QuestionToAdd.swift
//  Triviastic
//
//  Created by Moni Manolov on 15/03/2021.
//

import Foundation

class QuestionToAdd: Decodable, Encodable, ObservableObject{
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    //var hasImage: Bool
    
    
    enum CodingKeys: String, CodingKey {
            case question
            case answer1
            case answer2
            case answer3
            case answer4
           // case hasImage
        }
    
    init() {
        question = ""
               answer1 = ""
                answer2 = ""
                answer3 = ""
                answer4 = ""
        //hasImage = false
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        question = try container.decode(String.self, forKey: .question)
        answer1 = try container.decode(String.self, forKey: .answer1)

        answer2 = try container.decode(String.self, forKey: .answer2)
        answer3 = try container.decode(String.self, forKey: .answer3)

        answer4 = try container.decode(String.self, forKey: .answer4)
       // hasImage = try container.decode(Bool.self, forKey: hasImage)
    }

   
    
//    init(){
//        question = ""
//        answer1 = ""
//        answer2 = ""
//        answer3 = ""
//        answer4 = ""
//    }

}
