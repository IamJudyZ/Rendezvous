//
//  UploadProfilePictureViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class UploadProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView1: UIImageView!
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDashedBorder(imageView: imageView1)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setupProfile(_ sender: Any) {
        if checkFields() {
            //BING
//            updateUser()
//            do {
//                try _ = db.collection("users").document(userID).setData(from:self.currentUser)
//            } catch {
//                print("Unable to update user data on Firebase")
//            }
            transitionToHomeScreen()
        }
    }
    
    func updateUser() {
        //BING: the below doesn't work, need type conversion
        //currentUser.profilePic = imageView1.image
    }
    
    func checkFields() -> Bool {
        //BING: user need a profile picture before moving on
        return true
    }
    
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
            // BING: not sure what this does but I think it is after everything is done
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // check to see if uploaded image can be converted to a UIImage
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView1.image = image
            
            // BING: This is where you send the image to firebase
            }
        else {
            // BING: error message if uploaded image can't be converted
            print("error")
        }
        // leaves the screen to access photo library
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeDashedBorder(imageView: UIImageView) {
        let border = CAShapeLayer()
        border.strokeColor = UIColor.gray.cgColor
        border.lineDashPattern = [4, 4]
        border.lineWidth = 3
        border.cornerCurve = CALayerCornerCurve.circular
        border.frame = imageView.bounds
        border.fillColor = nil
        border.path = UIBezierPath(rect: imageView.bounds).cgPath
        imageView.layer.addSublayer(border)
    }
    
    func transitionToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
