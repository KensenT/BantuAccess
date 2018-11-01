//
//  postCell.swift
//  Bantu
//
//  Created by Steven Muliamin on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var needsCollectionView: UICollectionView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var currentPost: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(post: Post){
        self.currentPost = post
        
        self.thumbnail.image = self.currentPost.schoolImages[0]
        self.schoolNameLabel.text = self.currentPost.schoolName
        self.locationLabel.text = "\(self.currentPost.locationLocality), \(self.currentPost.locationAdminArea)"
        self.fullNameLabel.text = self.currentPost.fullName
        self.timeStampLabel.text = self.currentPost.timeStamp.beautifyDate()
        
        self.needsCollectionView.reloadData()
    }
}


extension postCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPost.needs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "needsCell", for: indexPath) as! needsCell
        cell.needsLabel.text = self.currentPost.needs[indexPath.row].needsName

        

        cell.needsLabel.backgroundColor = UIColor.cyan
        cell.needsLabel.layer.borderColor = UIColor.black.cgColor
        cell.needsLabel.layer.borderWidth = 1
        cell.needsLabel.layer.cornerRadius = 3
//
        return cell
    }
    
    
}
