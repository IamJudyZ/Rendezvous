//
//  user.swift
//  Rendezvous
//
//  Created by Ramses Sanchez Hernandez on 11/1/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit


//User object containing user non-private user info
//Used and stored both locally and remotley
//Codable ensures that it can be passed into fireStore database as custom object
class User: NSObject, Codable {
    var firstName: String
    var lastName: String
    var email: String
    
    //Init with full info
    init(fName: String, lName: String, eMail: String){
        self.firstName = fName
        self.lastName = lName
        self.email = eMail
    }
    
    //Init with no parameters
    override init()
    {
        self.firstName = ""
        self.lastName = ""
        self.email = ""
    }
}
