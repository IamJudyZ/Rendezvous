//
//  ProfileViewModel.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/19/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var profiles = [Profile]()
    let db = Firestore.firestore()
    
    func getProfiles() {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
        
            self.profiles = documents.map { queryDocumentSnapshot -> Profile in
                let data = queryDocumentSnapshot.data()
                // cast Any to String (as? String), or set to default "" (?? "")
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let name = firstName + " " + lastName
                let gender = data["gender"] as? String ?? ""
                let preference = data["preference"] as? String ?? ""
                let age = data["age"] as? String ?? ""
                let heightFeet = data["heightFeet"] as? String ?? ""
                let heightInch = data["heightInch"] as? String ?? ""
                let city = data["city"] as? String ?? ""
                let state = data["state"] as? String ?? ""
                let profession = data["profession"] as? String ?? ""
                let selfDescription = data["selfDescription"] as? String ?? ""
                let interests = data["interests"] as? Array<String> ?? []
                //let profilePic = data["profilePic"] as? String ?? ""
                let profilePic = "testPicture"
                
                return Profile(name: name, gender: gender, preference: preference, age: age, heightFeet: heightFeet, heightInch: heightInch, city: city, state: state, profession: profession, selfDescription: selfDescription, interests: interests, profilePic: profilePic, offset: 0)
            }
        }
    }
}
