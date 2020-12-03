//
//  ChangeInterestsViewController.swift
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

class ChangeInterestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    //Number of interests user needs to pick to move on
    var interestCount: Int = 3
    
    let columnLayout = CustomViewFlowLayout()
    
    var interestsCatalog = ["vegan", "women in tech", "elections", "music", "gaming",
                            "running", "gym", "dogs", "cats", "technology",
                            "basketball", "football", "chinese food", "beach",
                            "traveling", "baseball", "italian food", "daredevil",
                            "trivia", "cycling", "cars", "kids", "marvel",
                            "blockbusters", "arthouse", "rock climbing", "swimming",
                            "rom coms", "sitcoms", "thriller", "science fiction",
                            "classics", "classical music", "sustainability",
                            "social justice", "US politics", "world politics",
                            "photography", "art shows", "contemporary art",
                            "art history", "history", "movies"]
    
    var userInterests = [String]()
    
    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(InterestCell.nib(), forCellWithReuseIdentifier: InterestCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Setup CollectionView Auto-Layout
        if #available(iOS 10.0, *) {
            columnLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        else {
            columnLayout.estimatedItemSize = CGSize(width: 128, height: 20)
        }
        collectionView.collectionViewLayout = columnLayout
        
        errorLabel.isHidden = true
        instructionsLabel.text! = "Select \(interestCount) topics you are interested in"
    }
    
    func getInterest(for indexPath: IndexPath) -> String {
        return interestsCatalog[indexPath.row]
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
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateUser() {
        currentUser.interests = userInterests
    }
    
    func checkFields() -> Bool {
        if userInterests.count != 3 {
            callError(errorText: "Please select 3 topics you are interested in")
            return false
        }
        return true
    }
    
    func callError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestCell {
            let interest = cell.getText()!
            
            //If interest already selected, deselect it
            if userInterests.contains(interest) {
                guard let index = userInterests.firstIndex(of: interest) else {
                    return
                }
                userInterests.remove(at: index)
                interestCount = interestCount + 1
            }
            else {
                if userInterests.count < 3 {
                    userInterests.append(cell.getText()!)
                    interestCount = interestCount - 1
                }
            }
            
            //Update text display to reflect change
            interestsLabel.text! = UserHelper.formatInterestsString(userInterests: userInterests)
            instructionsLabel.text! = "Select \(interestCount) topics you are interested in"
            errorLabel.isHidden = true;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Num of cells
        return interestsCatalog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCell.identifier, for: indexPath) as! InterestCell
        
        let interestTextField = UITextField()
        interestTextField.text = getInterest(for: indexPath)
        // configure is a custom function in InterestCell.swift
        cell.configure(with: interestTextField)
        return cell
    }
}
