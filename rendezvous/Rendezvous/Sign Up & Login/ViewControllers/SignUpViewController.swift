//
//  signUpViewController.swift
//  Rendezvous
//
//  Created by Ramses Sanchez Hernandez on 11/2/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUp: UIButton!
    
    var user: User!
    
    let rendezvousBlue = UIColor.init(red: 0/255, green: 30/255, blue: 80/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        setUpTextField(firstName)
        setUpTextField(lastName)
        setUpTextField(email)
        setUpTextField(password)
        setUpTextField(confirmPassword)
        signUp.layer.cornerRadius = 15
        signUp.clipsToBounds = true
    }
    
    func setUpTextField(_ textField: UITextField) {
         let bottomLine = CALayer()
         bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height-5, width: textField.frame.width, height: 2)
         bottomLine.backgroundColor = rendezvousBlue.cgColor
         textField.background = .none
         textField.layer.addSublayer(bottomLine)
     }
    
    //Hide keyboard when user taps 'return' on keyboard
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        _textField.resignFirstResponder();
    }
    
    //Hide keyboard when user taps outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if checkFields() {
            //If all fields are filled trim white spaces and new line characters from all text fields
            let fName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pword =  password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create a new User object to pass into firestore
            let newUser = User(fName: fName, lName: lName, eMail: em)
            self.user = newUser;
            
            //Try to reach firebase and create a new user with email and password
            //If an issue occurs connecting to firebase display the error
            //Else create a new user with the info from the User object created above
            Auth.auth().createUser(withEmail: em, password: pword) { (result, error) in
                if error != nil {
                    self.callError(errorText: error!.localizedDescription)
                }
                else {
                    let db = Firestore.firestore()
                    do {
                        try db.collection("users").document(result!.user.uid).setData(from:self.user)
                    }
                    catch {
                        print("Unable to add new user to firestore")
                    }
                    //If all else successful, transition to the setup profile
                    self.performSegue(withIdentifier: "setupSegue", sender: nil)
                }
            }
        }
    }
    
    //Ensure form is filled in correctly
    //Else return false
    func checkFields() -> Bool {
        //Ensure all fields filled out
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            callError(errorText: "One or more fields have been left empty")
            return false
        }

        //Calls isValidPassword to make sure it is a Strong password
        if isValidPassword(password: password.text!) == false {
            callError(errorText: "Password must include at least one number, a special character ($@$#!%?&), and an uppercase letter.")
            return false
        }
        
        //Make sure the two password text fields match
        if confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) != password.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            callError(errorText: "Passwords do not match")
            return false
        }
        return true
    }
    
    func callError(errorText: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorText
    }
    
    func isValidPassword(password: String) -> Bool {
        //Password requires 1 uppercase, 1 lowercase, one special char, one number, length 8
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[$@$#!%*?&])(?=.*[0-9])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setupSegue" {
            let destinationVC = segue.destination as! SetupProfileViewController
            destinationVC.currentUser = self.user
        }
    }
}
