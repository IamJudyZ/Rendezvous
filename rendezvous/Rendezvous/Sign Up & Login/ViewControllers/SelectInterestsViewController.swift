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
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(InterestCell.nib(), forCellWithReuseIdentifier: InterestCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // TODO: sample layout stuff Bing needs to work with after Ramses finishes backend
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30, height: 20)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //When an item is selected
        //First deselect what was selected before
        collectionView.deselectItem(at: indexPath, animated: true)
        // temporary sample action
        print("you tapped me")
        
        // BING: This is where you implement what happens when an interest item is selected
        // should be added to the user's profile
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Num of cells
        //BING: should be changed to be the size of interests list imported from database
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCell.identifier, for: indexPath) as! InterestCell
        
        //BING: UITextField should be the name of the interest. Uncomment once UITextField becomes available
        // configure is a custom function in InterestCell.swift
//        cell.configure(with: UITextField)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Setup layout for cell
        // TODO: fine tune layout after Ramses is done with backend
        return CGSize(width: 30, height: 20)
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


// BING: Ignore all this, it is repeated above
//extension ViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //When an item is selected
//        //First deselect what was selected before
//        collectionView.deselectItem(at: indexPath, animated: true)
//        print("you tapped me")
//    }
//}

//extension ViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 12
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
//        return cell
//    }
//}

//extension ViewController: UICollectionViewDelegateFlowLayout {}

