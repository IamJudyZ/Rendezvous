//
//  SelectInterestsViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class SelectInterestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var welcomeText: UILabel!
    let columnLayout = CustomViewFlowLayout()
    
    //BING: it works fine with the list hardcoded here, so you don't need to retrieve from database if you don't want. 
    var interestsCatalog = ["vegan", "women in tech", "elections", "music", "gaming",
                            "running", "gym", "dogs", "cats", "technology",
                            "basketball", "football", "chinese food", "beach",
                            "traveling", "baseball", "italian food", "daredevil",
                            "trivia", "cycling", "cars", "kids"]
    
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
        welcomeText.text!="welcome, " + currentUser.firstName + "!"
    }
    
    func getInterest(for indexPath: IndexPath) -> String {
        return interestsCatalog[indexPath.row]
    }
    
    @IBAction func setupProfile(_ sender: Any) {
        if checkFields() {
            updateUser()
            do {
                try db.collection("users").document(userID).setData(from:self.currentUser)
            }
            catch {
                print("Unable to update user data on Firebase")
            }
            self.performSegue(withIdentifier: "uploadSegue", sender: nil)
        }
    }
    
    func updateUser() {
        currentUser.interests = userInterests
    }
    
    func checkFields() -> Bool {
        //BING: user has to choose 3 interests before moving on
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //When an item is selected
        //First deselect what was selected before
        //collectionView.deselectItem(at: indexPath, animated: true)
        // temporary sample action
        print("you tapped me")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestCell {
            //BING: changing background color here doesn't work, changing it in the collection view cell (InterestCell.swift) doesn't work, changing it in storyboard doesn't work either
            //cell.backgroundColor = UIColor.blue
            
            //BING: some sort of check so that user can only have 3 interests at a time if userInterests.size is less than 3, then add to userInterests
            userInterests.append(cell.getText()!)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uploadSegue" {
            let destinationVC = segue.destination as! UploadProfilePictureViewController
            destinationVC.currentUser = self.currentUser
        }
    }
}
