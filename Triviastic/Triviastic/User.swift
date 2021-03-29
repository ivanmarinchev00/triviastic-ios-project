//
//  User.swift
//  Triviastic
//
//  Created by Moni Manolov on 16/03/2021.
//

import Foundation
import FirebaseFirestore
import Firebase
 

class User: Codable {
    var uuid: String
    var email: String
    var connections: [String]
    var points: Int
    var isAdmin: Bool
    
//    enum CodingKeys: String, CodingKey {
//            case question
//            case answer1
//            case answer2
//            case answer3
//            case answer4
//           // case hasImage
//        }
    
    init() {
        uuid = ""
        email = ""
        connections = []
        points = 0
        isAdmin = false
    }
    
    init(_ uuid: String, _ email: String){
        self.uuid = uuid
        self.email = email
        connections = []
        points = 0
        isAdmin = false
    }
    
    init(snapshot: DocumentSnapshot) {
            uuid = snapshot.documentID
            let snapshotValue = snapshot.data()
        email = snapshotValue?["email"] as? String ?? ""
        connections = snapshotValue?["connections"] as? [String] ?? []
        points = snapshotValue?["points"] as? Int ?? 0
        isAdmin = snapshotValue?["isAdmin"] as? Bool ?? false
        }
    
    
    
}
