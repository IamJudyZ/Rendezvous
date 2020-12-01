//
//  ChangePasswordViewController.swift
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

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var currentUser: User!
    var user = Auth.auth().currentUser

    var credential: AuthCredential = EmailAuthProvider.credential(withEmail: "email", password: "pass")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.isHidden = true
    }
   
    func callError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false;
    }
    
    @IBAction func changePassword(_ sender: Any) {
        credential = EmailAuthProvider.credential(withEmail: user?.email ?? currentUser.email, password: oldPasswordText.text!)
       
        user?.reauthenticate(with: credential) { error, authResult in
            if let error = error {
                // An error happened.
                self.callError(errorText: "Unable to reauthenticate")
                print(error)
            }
            else {
                // User re-authenticated.
                if self.checkFields() {
                    self.changeUserPassword()
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
    }
    
    func changeUserPassword() {
        Auth.auth().currentUser?.updatePassword(to: self.newPasswordText.text!) { (error) in
        }
    }
    
    func checkFields() -> Bool {
        //Ensure all fields filled out
        if newPasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            callError(errorText: "One or more fields have been left empty")
            return false
        }

        //Calls isValidPassword to make sure it is a Strong password
        if isValidPassword(password: newPasswordText.text!) == false {
            callError(errorText: "Password must include at least one number, a special character ($@$#!%?&), and an uppercase letter.")
            return false
        }
        
        //Make sure the two password text fields match
        if confirmPasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) != newPasswordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            callError(errorText: "Passwords do not match")
            return false
        }
        return true
    }
    
    func isValidPassword(password: String) -> Bool {
        //Password requires 1 uppercase, 1 lowercase, one special char, one number, length 8
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[$@$#!%*?&])(?=.*[0-9])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
