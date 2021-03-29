//
//  Question.swift
//  Triviastic
//
//  Created by Ivan Marinchev on 3/15/21.
//

import Foundation

struct Question: Identifiable {
    var id: String = UUID().uuidString
    var points: Int
    var question: String
    var rightAnswer: String
    var wAnswer1: String
    var wAnswer2: String
    var wAnswer3: String
    var hint: String
    var questionId: String
    
    
}
