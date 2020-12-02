//
//  MyProfileViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/23/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseUI
//import SDWebImage

class MyProfileViewController: UIViewController {

    @IBOutlet weak var myProfileBackgroundCard: UIStackView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var interest1Text: UITextField!
    @IBOutlet weak var interest2Text: UITextField!
    @IBOutlet weak var interest3Text: UITextField!
    @IBOutlet weak var professionHeightText: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var editButton: UIButton!
    
    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //getUserProfileImage()
        //RAMSES: The positioning of this next line is important, it may be necessary to write this some place else
        //self.initText();
        //setupViews()
        //getUserInfo()
        getUserInfo()
        getUserProfileImage()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserProfileImage()
    }
    
    //override func viewWillAppear(_ animated: Bool) {
        //self.currentUser = UserHelper.userInfo(uid: userID)
        //self.currentUser = UserHelper.userInfo(uid: userID)
        //getUserProfileImage()
        //self.initText()
    //}
    
    func setupViews() {
        //BackgroundCard round edges
        self.myProfileBackgroundCard.layer.cornerRadius = self.myProfileBackgroundCard.frame.size.height / 30
        //Button round edges
        self.editButton.layer.cornerRadius = self.editButton.frame.size.height / 2
    }
    
    func getUserProfileImage(){
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        let imageRef = storage.reference().child("ProfileImages/\(userID)Profile.jpg")
        profilePic.sd_setImage(with: imageRef)
    }
    
        
    //See UserHelper.swift
    func getUserInfo() {
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
                    self.currentUser = newUserFromDb
                    self.initText()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func initText() {
        //TODO: change profilePic to retrieve from backen
        //profilePic.image = UIImage(named: "profilePic")
        nameText.text! = currentUser.firstName + " " + currentUser.lastName
        ageText.text! = currentUser.age
        locationText.text! = currentUser.city  + ", " + currentUser.state
        interest1Text.text! = currentUser.interests[0]
        interest2Text.text! = currentUser.interests[1]
        interest3Text.text! = currentUser.interests[2]
        professionHeightText.text! = currentUser.profession + " • " + currentUser.heightFeet + "\'" + currentUser.heightInch + "\""
        descriptionTextView.text! = currentUser.selfDescription
        getUserProfileImage()
    }
}
