//
//  UploadProfilePictureViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

// This lets users upload a picture from their photo library. It currently does not have functionality to take a picture with the camera yet
//BING: I made this from 2 tutorials: one that shows how to make ImageViews tappable (all the stuff having to do with GestureRecognizer) and one that lets users upload photos (all the ImagePickerController stuff)
//BING: Also not sure if we decided to go with multiple profile pics, but the one I setup only has one. I named it imageView1 in case we wanted to add more so we can just do imageView2, etc.
class UploadProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDashedBorder(imageView: imageView1)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView1.isUserInteractionEnabled = true
            imageView1.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // this has to do with letting users click on the imageview to upload a photo. Not sure if it is needed tho
        let tappedImage = tapGestureRecognizer.view as! UIImageView

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
