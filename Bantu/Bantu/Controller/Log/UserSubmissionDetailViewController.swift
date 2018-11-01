//
//  EventDetailViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreLocation
import MapKit

class UserSubmissionDetailViewController: UIViewController {
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UITextView!
    @IBOutlet weak var needsCollectionView: UICollectionView!
    @IBOutlet weak var accessLabel: UITextView!
    @IBOutlet weak var addressLabel: UITextView!
    @IBOutlet weak var notesLabel: UITextView!

    
    @IBOutlet weak var mySubmissionMapView: MKMapView!
    @IBOutlet weak var bukaMapButton: UIButton!
    @IBOutlet weak var myImageSlide: ImageSlideshow!
    var images: [ImageSource] = []
    
    var currentSubmission: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bukaMapButton.buttonDesign()
        
        self.setUp()
        self.setLocationOnMap(userLocation: CLLocation(latitude: self.currentSubmission.locationLatitude, longitude: self.currentSubmission.locationLongitude))
        
    }
    
    func setLocationOnMap(userLocation: CLLocation) {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.mySubmissionMapView.setRegion(region, animated: true)
        self.mySubmissionMapView.showsUserLocation = true
    }
    
    @IBAction func bukaMapsTapped(_ sender: Any) {
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.currentSubmission.locationLatitude),\(self.currentSubmission.locationLongitude)"
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
        self.schoolNameLabel.text = self.currentSubmission.schoolName
        self.aboutLabel.text = self.currentSubmission.about
        self.accessLabel.text = self.currentSubmission.access
        self.addressLabel.text = self.currentSubmission.address
        self.notesLabel.text = self.currentSubmission.notes
        
        for x in self.currentSubmission.schoolImages{
            self.images.append(ImageSource(image: x))
        }
        for x in self.currentSubmission.roadImages{
            self.images.append(ImageSource(image: x))
        }
        
        self.myImageSlide.slideshowInterval = 0
        self.myImageSlide.circular = false
        self.myImageSlide.zoomEnabled = true
        self.myImageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        self.myImageSlide.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        self.myImageSlide.pageIndicator = pageControl
        self.myImageSlide.setImageInputs(self.images)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        self.myImageSlide.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func didTap() {
        self.myImageSlide.presentFullScreenController(from: self)
    }
}

extension UserSubmissionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentSubmission.needs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userSubmissionNeedsCell", for: indexPath) as! NeedSubmissionCell
        cell.needSubmissionLabel.text = self.currentSubmission.needs[indexPath.row].needsName
        
        cell.needSubmissionLabel.layer.borderColor = UIColor.black.cgColor
        cell.needSubmissionLabel.layer.borderWidth = 1
        cell.needSubmissionLabel.layer.cornerRadius = 3
        cell.needSubmissionLabel.backgroundColor = UIColor.cyan
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.needsCollectionView.frame.width/4-10, height: 20)
    }
    
}
