//
//  ManageAccountViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/16/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class ManageAccountViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initText()
        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }
    

    func initText() {
        firstNameText.text! = currentUser.firstName
        lastNameText.text! = currentUser.lastName
        emailText.text! = currentUser.email
    }
    
    func updateUser() {
        currentUser.firstName = firstNameText.text!
        currentUser.lastName = lastNameText.text!
        // user is not allowed to change email
    }
    
    func callError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false;
    }
    
    func checkFields() -> Bool {
        //Ensure all fields filled out
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            callError(errorText: "One or more fields have been left empty")
            return false
        }
        return true
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        if (checkFields()) {
            updateUser()
            do {
                try db.collection("users").document(userID).setData(from:self.currentUser)
            } catch {
                print("Unable to update user data on Firebase")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func changePassword(_ sender: Any) {
        self.performSegue(withIdentifier: "passwordSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "passwordSegue") {
            let destinationVC = segue.destination as! ChangePasswordViewController
            destinationVC.currentUser = self.currentUser
        }
    }
}
