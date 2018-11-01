//
//  userSubmissionCell.swift
//  Bantu
//
//  Created by Steven Muliamin on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class userSubmissionCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var currentSubmission: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(post: Post){
        self.currentSubmission = post
        
        self.thumbnail.image = self.currentSubmission.schoolImages[0]
        self.schoolName.text = self.currentSubmission.schoolName
        self.locationLabel.text = "\(self.currentSubmission.locationLocality), \(self.currentSubmission.locationAdminArea)"
        self.timeStampLabel.text = self.currentSubmission.timeStamp
        self.statusLabel.text = self.currentSubmission.statusName
        
        if (self.currentSubmission.statusName == "Accepted"){
            self.statusLabel.textColor = UIColor.green
        }
        else if (self.currentSubmission.statusName == "Pending"){
            self.statusLabel.textColor = UIColor.orange
        }
        else{
            self.statusLabel.textColor = UIColor.red
        }
    }


}
