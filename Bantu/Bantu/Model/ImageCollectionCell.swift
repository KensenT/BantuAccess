//
//  ImageCollectionCell.swift
//  Bantu
//
//  Created by Gior Fasolini on 15/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    func setImage(image: UIImage) {
        self.myImageView.image = image
    }
}
