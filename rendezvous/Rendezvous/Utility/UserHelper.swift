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
    
    static func formatInterestsString(userInterests: [String]) -> String {
        let numOfInterests = userInterests.count
        var interestsString: String = "You've selected "
        for item in userInterests {
            let index = userInterests.firstIndex(of: item)
            if numOfInterests == 1 {
                interestsString = interestsString + item + "."
            }
            else if numOfInterests == 2 {
                if index == 0 {
                    interestsString = interestsString + item + " and "
                }
                else if index == 1 {
                    interestsString = interestsString + item + "."
                }
            }
            else if numOfInterests == 3 {
                if index == 0 {
                    interestsString = interestsString + item + ", "
                }
                else if index == 1 {
                    interestsString = interestsString + item + ", and "
                }
                else if index == 2 {
                    interestsString = interestsString + item + "."
                }
            }
        }
        if numOfInterests != 0 {
            return interestsString
        }
        else {
            return ""
        }
    }
}
