//
//  EventDetailViewController.swift
//  Bantu
//
//  Created by Steven Muliamin on 17/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class EventDetailViewController: UIViewController {

    //MARK: Outlet imageView
    @IBOutlet weak var eventImg: UIImageView!
    
    //MARK: Outlet UILabel
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var aboutEventLabel: UILabel!
    @IBOutlet weak var lokasiLabel: UILabel!
    
    //MARK: Outlet textView
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: Outlet UIButton
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var bukaMapsButton: UIButton!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    @IBOutlet weak var mapsView: MKMapView!
    var currentEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.joinButton.buttonDesign()
        self.bukaMapsButton.buttonDesign()
        self.setLocationOnMap(userLocation: CLLocation(latitude: self.currentEvent.locationLatitude, longitude: self.currentEvent.locationLongitude))
       
        self.setUp()
        self.setAllLabelDynamic()
    }
    
    func setAllLabelDynamic() {
        self.eventNameLabel.setDynamic(fontFamily: "Helvetica", size: 16, style: "bold", type: .headline)
        self.timeLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.locationLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.feeLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.aboutEventLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        self.descriptionTextView.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.seeMoreButton.setDynamic(fontFamily: "Helvetica", size: 12, style: "", type: .body)
        self.lokasiLabel.setDynamic(fontFamily: "Helvetica", size: 12, style: "bold", type: .subheadline)
        self.bukaMapsButton.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .body)
        self.bukaMapsButton.titleLabel?.textAlignment = .center
        self.joinButton.setDynamic(fontFamily: "Helvetica", size: 14, style: "bold", type: .body)
        self.joinButton.titleLabel?.textAlignment = .center
    }
    
    @IBAction func bukaMapsTapped(_ sender: Any) {
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
    
    func setLocationOnMap(userLocation: CLLocation) {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.mapsView.setRegion(region, animated: true)
        self.mapsView.showsUserLocation = true
    }
    
    
    @IBAction func joinButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "eventDetailToRegister", sender: self)
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
        if(segue.identifier == "EventDetailToEventDetailMore"){
            let destination = segue.destination as! EventDetailMoreViewController
            destination.currentEvent = self.currentEvent
        }
    }

    @IBAction func seeMoreButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "EventDetailToEventDetailMore", sender: self)
    }
}
