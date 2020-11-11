//
//  SelectInterestsViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

//BING: This is where you implement the logic to retrieve a list of interests from the database and assign each interest to a cell in the UICollectionView. The code I've added is for setting up the collectionView to store each interest item
class SelectInterestsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let columnLayout = CustomViewFlowLayout()
    var interestsCatalog = ["vegan", "women in tech", "elections", "music", "gaming",
                            "running", "gym", "dogs", "cats", "technology",
                            "basketball", "football", "chinese food", "beach",
                            "traveling", "baseball", "italian food", "daredevil",
                            "trivia", "cycling", "cars", "kids"]
    
    var currentUser: User!
    
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
    }
    
    func getInterest(for indexPath: IndexPath) -> String {
        return interestsCatalog[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //When an item is selected
        //First deselect what was selected before
        //collectionView.deselectItem(at: indexPath, animated: true)
        // temporary sample action
        print("you tapped me")
        
        if let cell = collectionView.cellForItem(at: indexPath) as? InterestCell {
//            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//            print(cell)
            cell.backgroundColor = UIColor.blue
        }
        // BING: This is where you implement what happens when an interest item is selected => indexPath.item
        // should be added to the user's profile
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
