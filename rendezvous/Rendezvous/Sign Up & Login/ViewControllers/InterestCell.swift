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
    
    //var cachedSize: CGSize?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        interest.isUserInteractionEnabled = false
        self.layer.cornerRadius = self.frame.size.height / 6
        
//        let lightGrayView = UIView(frame: bounds)
//        lightGrayView.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//        self.backgroundView = lightGrayView
//
//        let redView = UIView(frame: bounds)
//        redView.backgroundColor = .red
//        self.selectedBackgroundView = nil
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
    public func configure(with cellText: UITextField) {
        interest.text = cellText.text
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    //Auto-Layout cell sizes
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.width = CGFloat(ceilf(Float(size.width)))
        frame.size.height = CGFloat(ceilf(Float(size.height)))
        layoutAttributes.frame = frame
        //cachedSize = frame.size
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.interest.layer.cornerRadius = self.frame.size.height/2
    }
}


