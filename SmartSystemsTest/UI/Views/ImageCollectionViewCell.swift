//
//  ImageCollectionViewCell.swift
//  SmartSystemsTest
//
//  Created by Dima Paliychuk on 5/4/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import UIKit
import SwiftyGif

class ImageCollectionViewCell: UICollectionViewCell, SwiftyGifDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.delegate = self
    }
}
