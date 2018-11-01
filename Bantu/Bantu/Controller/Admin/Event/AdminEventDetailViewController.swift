//
//  AdminEventDetailViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 17/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class AdminEventDetailViewController: UIViewController {

    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var bukaAdminMapsButton: UIButton!
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bukaAdminMapsButton.buttonDesign()

        self.setUp()

    }
    
    @IBAction func openAdminMaps(_ sender: Any) {
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.currentEvent.locationLatitude),\(self.currentEvent.locationLongitude)"
            if UIApplication.shared.canOpenURL(NSURL(string: url)! as URL) {
            UIApplication.shared.openURL(URL(string:url)!)
        }
        else {
                let alert = UIAlertController(title: "Error", message: "Please Install Apple Maps", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setUp(){
        self.eventImg.image = self.currentEvent.img
        self.eventNameLabel.text = self.currentEvent.eventName
        self.timeLabel.text = "\(self.currentEvent.startDate.beautifyDate()) - \(self.currentEvent.endDate.beautifyDate())"
        self.locationLabel.text = "\(self.currentEvent.locationLocality), \(self.currentEvent.locationAdminArea)"
        self.feeLabel.text = "Rp. \(self.currentEvent.fee)"
        self.descriptionTextView.text = self.currentEvent.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "adminEventDetailToMore"){
            let destination = segue.destination as! AdminEventDetailMoreViewController
            destination.currentEvent = self.currentEvent
        }
    }
    
    @IBAction func seeMoreButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "adminEventDetailToMore", sender: self)
    }
    


}
