//
//  SubmissionDetailViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import ImageSlideshow

class SubmissionDetailViewController: UIViewController {
    
    var currentPost: Post!
    let need: [String] = ["Buku", "Pencil","Baju"]
    
    @IBOutlet weak var openMapsButton: UIButton!
    @IBOutlet weak var myImageSlide: ImageSlideshow!
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBOutlet weak var needsCollectionView: UICollectionView!
    
    var images: [ImageSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openMapsButton.buttonDesign()
        
        self.setUpPost()
        self.setUpMap()
    }
    
    @IBAction func openMapsTapped(_ sender: Any) {
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.currentPost.locationLatitude),\(self.currentPost.locationLongitude)"
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
    
    
    func setUpPost(){
        self.schoolNameLabel.text = self.currentPost.schoolName
        self.aboutTextView.text = self.currentPost.about
        self.accessTextView.text = self.currentPost.access
        self.addressTextView.text = self.currentPost.address
        self.notesTextView.text = self.currentPost.notes
        
        for x in self.currentPost.schoolImages{
            self.images.append(ImageSource(image: x))
        }
        for x in self.currentPost.roadImages{
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
    
    func setUpMap() {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.currentPost.locationLatitude, self.currentPost.locationLongitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.myMapView.setRegion(region, animated: true)
        self.myMapView.showsUserLocation = true
    }
    
    @IBAction func acceptButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Terima Submission", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let acceptAction = UIAlertAction(title: "Terima", style: .default) { (UIAlertAction) in
            PostServices.updatePostStatus(postId: self.currentPost.postId, statusId: 1){}
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func rejectButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Tolak Submission", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let rejectAction = UIAlertAction(title: "Tolak", style: .default) { (UIAlertAction) in
            PostServices.updatePostStatus(postId: self.currentPost.postId, statusId: 2){}
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(rejectAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SubmissionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentPost.needs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NeedSubmissionCell
        cell.needSubmissionLabel.text = self.currentPost.needs[indexPath.row].needsName
        
        cell.needSubmissionLabel.layer.borderColor = UIColor.black.cgColor
        cell.needSubmissionLabel.layer.borderWidth = 1
        cell.needSubmissionLabel.layer.cornerRadius = 3
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.needsCollectionView.frame.width/4-10, height: 20)
        
    }
    
    
}
