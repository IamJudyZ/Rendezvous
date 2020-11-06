//
//  InterestCell.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

// This class sets up a CollectionViewCell so each interest item can look the same
class InterestCell: UICollectionViewCell {

    @IBOutlet var interest: UITextField!
    static let identifier = "InterestCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with cellText: UITextField) {
        //BING: This is where you set the text of each cell to the name of the interest you retrieve from the database. cellText is what you retrieved. interest is what needs to be set. Both are UITextFields
        // can be done either here or where this function is called
        
        interest.text = cellText.text
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
