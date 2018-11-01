//
//  HomeCell.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var locationIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell(event: Event){
        self.eventImageView.image = event.img
        self.eventTitleLabel.text = event.eventName
        self.eventTitleLabel.setDynamic(fontFamily: "Helvetica", size: 16, style: "bold", type: .headline)
        self.dateLabel.text = "\(event.startDate.beautifyDate()) - \(event.endDate.beautifyDate())"
        self.dateLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.locationLabel.text = "\(event.locationLocality), \(event.locationAdminArea)"
        self.locationLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        
        self.eventImageView.accessibilityIgnoresInvertColors = true
    }
    
}

