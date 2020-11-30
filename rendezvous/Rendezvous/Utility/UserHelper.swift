//
//  UserHelper.swift
//  Rendezvous
//
//  Created by Ramses Sanchez Hernandez on 11/29/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class UserHelper {
    static func userInfo(uid: String) -> User {
        var currentUser = User.init()
        let db = Firestore.firestore()
        let userID = uid
        db.collection("users").document(userID).getDocument { (document, error) in
            if let error = error {
                print(error)
                return
            }
            let result = Result {
                try document?.data(as: User.self)
            }
            switch result {
                case .success(let newUserFromDb):
                    currentUser = newUserFromDb!
                case .failure(let error):
                    print(error)
            }
        }
        return currentUser
    }
    
    static func updateUser(user: User, uid: String) {
        let currentUser = user
        let userID = uid
        let db = Firestore.firestore()
        do {
            try db.collection("users").document(userID).setData(from:currentUser)
        }
        catch {
            print("Unable to update user data on Firebase")
        }
    }
}
