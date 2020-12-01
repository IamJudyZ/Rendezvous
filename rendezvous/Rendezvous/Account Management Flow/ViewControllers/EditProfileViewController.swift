//
//  EditProfileViewController.swift
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

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var preferenceText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var heightFeetText: UITextField!
    @IBOutlet weak var heightInchText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var professionText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var interestsText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //Components for PickerViews
    var selectedGender: String?
    var selectedGenderRow: Int = 0
    var genderList = ["", "Woman", "Man", "Other"]
    var selectedPreference: String?
    var selectedPreferenceRow: Int = 0
    var preferenceList = ["", "Woman", "Man", "Everyone"]
    var selectedAge: String?
    var selectedAgeRow: Int = 0
    var ageList = [""]
    var selectedHeightFeet: String?
    var selectedHeightFeetRow: Int = 0
    var heightFeetList = ["", "3", "4", "5", "6", "7", "8", "9"]
    var selectedHeightInch: String?
    var selectedHeightInchRow: Int = 0
    var heightInchList = ["", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    //Keeps track of which PickerView TextField is selected
    var currentTextField: UITextField!
    var pickerView = UIPickerView()
    
    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createAgeList()
        getUserInfo()
        errorLabel.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGestureRecognizer)
        
        interestsText.delegate = self
        interestsText.addTarget(self, action: #selector(changeInterests), for: .touchDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    
    func createAgeList() {
        for num in 18...65 {
            ageList.append(String(num))
        }
    }

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
        //BING: Need to initialize imageView1 with the photo stored as profile picture in database
        genderText.text! = currentUser.gender
        preferenceText.text! = currentUser.preference
        ageText.text! = currentUser.age
        heightFeetText.text! = currentUser.heightFeet
        heightInchText.text! = currentUser.heightInch
        cityText.text! = currentUser.city
        stateText.text! = currentUser.state
        professionText.text! = currentUser.profession
        //let description = String(currentUser.selfDescription)
        descriptionText.text! = currentUser.selfDescription
        var interestText = ""
        for interest in currentUser.interests {
            if interest == currentUser.interests[currentUser.interests.count - 1] {
                interestText += interest + "..."
            }
            else {
                interestText += interest + ", "
            }
        }
        interestsText.text! = interestText
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        if checkFields() {
            updateUser()
            do {
                try db.collection("users").document(userID).setData(from:self.currentUser)
            }
            catch {
                print("Unable to update user data on Firebase")
            }
            transitionToHomeScreen()
        }
    }
    
    func updateUser() {
        //BING: need to update profile image
        currentUser.gender = genderText.text!
        currentUser.preference = preferenceText.text!
        currentUser.age = ageText.text!
        currentUser.heightFeet = heightFeetText.text!
        currentUser.heightInch = heightInchText.text!
        currentUser.city = cityText.text!
        currentUser.state = stateText.text!
        currentUser.profession = professionText.text!
        currentUser.selfDescription = descriptionText.text!
    }
    
    func checkFields() -> Bool {
        //BING: need to make sure there is a profile image
        //Ensure all fields filled out
        if genderText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || preferenceText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ageText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || heightFeetText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || heightInchText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || cityText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || stateText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || professionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || descriptionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            callError(errorText: "One or more fields have been left empty")
            return false
        }
        return true
    }
    
    func callError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false;
    }
    
    @IBAction func manageAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "accountSegue", sender: nil)
    }
    
    @objc func changeInterests(_ sender: Any) {
        self.performSegue(withIdentifier: "interestsSegue", sender: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "accountSegue") {
            let destinationVC = segue.destination as! ManageAccountViewController
            destinationVC.currentUser = self.currentUser
        }
        if (segue.identifier == "interestsSegue") {
            let destinationVC = segue.destination as! ChangeInterestsViewController
            destinationVC.currentUser = self.currentUser
        }
    }
    
    //PickerView functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentTextField {
            case genderText: return genderList.count
            case preferenceText: return preferenceList.count
            case ageText: return ageList.count
            case heightFeetText: return heightFeetList.count
            case heightInchText: return heightInchList.count
            default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentTextField {
            case genderText: return genderList[row]
            case preferenceText: return preferenceList[row]
            case ageText: return ageList[row]
            case heightFeetText: return heightFeetList[row]
            case heightInchText: return heightInchList[row]
            default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentTextField {
            case genderText:
                selectedGender = genderList[row]
                genderText.text = selectedGender
                selectedGenderRow = row
            case preferenceText:
                selectedPreference = preferenceList[row]
                preferenceText.text = selectedPreference
                selectedPreferenceRow = row
            case ageText:
                selectedAge = ageList[row]
                ageText.text = selectedAge
                selectedAgeRow = row
            case heightFeetText:
                selectedHeightFeet = heightFeetList[row]
                heightFeetText.text = selectedHeightFeet
                selectedHeightFeetRow = row
            case heightInchText:
                selectedHeightInch = heightInchList[row]
                heightInchText.text = selectedHeightInch
                selectedHeightInchRow = row
            default:
                print("No field selected")
        }
    }
    
    //Creates a PickerView within a UITextField
    func createPickerView(textField: UITextField) {
        textField.inputView = pickerView
    }
    
    //Close PickerView once something is selected
    func dismissPickerView(textField: UITextField) {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicking))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       textField.inputAccessoryView = toolBar
    }
    
    //Leaves the PickerView when user push the Done button
    @objc func donePicking() {
        view.endEditing(true)
    }
    
    //Delegate which picks up which PickerView TextField the user is in
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField
        
        //Select empty item by default and if re-enter TextField, will stay on selected item
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        switch currentTextField {
            case genderText:
                if selectedRow != selectedGenderRow {
                    pickerView.selectRow(selectedGenderRow, inComponent: 0, animated: false)
                }
            case preferenceText:
                if selectedRow != selectedPreferenceRow {
                    pickerView.selectRow(selectedPreferenceRow, inComponent: 0, animated: false)
                }
            case ageText:
                if selectedRow != selectedAgeRow {
                    pickerView.selectRow(selectedAgeRow, inComponent: 0, animated: false)
                }
            case heightFeetText:
                if selectedRow != selectedHeightFeetRow {
                    pickerView.selectRow(selectedHeightFeetRow, inComponent: 0, animated: false)
                }
            case heightInchText:
                if selectedRow != selectedHeightInchRow {
                    pickerView.selectRow(selectedHeightInchRow, inComponent: 0, animated: false)
                }
            default: print(selectedRow)
        }
        
        createPickerView(textField: currentTextField)
        dismissPickerView(textField: currentTextField)
    }
    
    //BING: you will need to copy over what you did for the upload image from login/register
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // this has to do with letting users click on the imageview to upload a photo. Not sure if it is needed tho
        //let tappedImage = tapGestureRecognizer.view as! UIImageView

        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        // starts the screen to access photo library
        self.present(image, animated: true) {
            // TODO
        }
    }
    //BING: Same as above
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // check to see if uploaded image can be converted to a UIImage
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView1.image = image
            
            // TODO
            }
        else {
            // TODO
            print("error")
        }
        // leaves the screen to access photo library
        self.dismiss(animated: true, completion: nil)
    }
        
    func transitionToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
