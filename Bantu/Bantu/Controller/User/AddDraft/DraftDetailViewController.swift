//
//  DraftDetailViewController.swift
//  Bantu
//
//  Created by Gior Fasolini on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//


//MARK: Importing Library
import UIKit
import CoreData
import MapKit
import CoreLocation


class DraftDetailViewController: UIViewController {

    //MARK: Outlet for textview & textfield
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var studentNoTextView: UITextView!
    @IBOutlet weak var teacherNoTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    //MARK: Outlet for scroll view
    @IBOutlet weak var draftDetailScrollView: UIScrollView!
    
    
    //MARK: Outlet for collection view
    @IBOutlet weak var needCollectionView: UICollectionView!
    @IBOutlet weak var schoolCollectionView: UICollectionView!
    @IBOutlet weak var roadCollectionView: UICollectionView!
    
    
    //MARK: Outlet for mapview
    @IBOutlet weak var myMapView: MKMapView!
    
    
    //MARK: Outlet for uibutton
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var openMapsButton: UIButton!
    
    
    //MARK: Variable Declaration
    var isNewDraft: Bool!
    var isCurrentlyEditing: Bool = false
    var currentDraft: Post!
    
    var locationManager = CLLocationManager()
    
    var needs: [Needs] = []
    var parallel: [Bool] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonTapped))
        setInitialLoadFromCoreData()
        
        
        self.schoolNameTextField.setIndentLeftPadding()
        
        self.postButton.buttonDesign()
        self.openMapsButton.buttonDesign()
        
        
        self.fetchAllNeedsFromCoreData()
    }
    
    func setNeeds(){
        for _ in 0..<self.needs.count{
            self.parallel.append(false)
        }
        
        for postNeed in self.currentDraft.needs{
            for i in 0..<self.needs.count{
                if (postNeed.needsId == self.needs[i].needsId){
                    self.parallel[i] = true
                    break
                }
            }
        }
    }
    
    func fetchAllNeedsFromCoreData() {
        
        let fetchRequest: NSFetchRequest<NeedsEntity> = NeedsEntity.fetchRequest()
        do{
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            let tempResult = fetchData
            
            for x in tempResult {
                let needsId: Int = Int(x.needsId)
                let needsName: String = x.needsName!
                let newNeed = Needs(needsId: needsId, needsName: needsName)
                self.needs.append(newNeed)
            }
            self.setNeeds()
            self.needCollectionView.reloadData()
            
        } catch {
            print("Fetch from core data fail")
        }
    }
    
    
    func setInitialLoadFromCoreData() {
        self.schoolNameTextField.text = self.currentDraft.schoolName
        self.aboutTextView.text = self.currentDraft.about
        self.addressTextView.text = self.currentDraft.address
        self.studentNoTextView.text = "\(self.currentDraft.studentNo)"
        self.teacherNoTextView.text = "\(self.currentDraft.teacherNo)"
        self.accessTextView.text = self.currentDraft.access
        self.notesTextView.text = self.currentDraft.notes
    }

    
    @objc func editButtonTapped() {
        
        
    }

        @IBAction func hideKeyboard(_ sender: Any) {
        draftDetailScrollView.endEditing(true)
    }
    
    @IBAction func openInAppleMaps(_ sender: Any) {
        let url = "http://maps.apple.com/maps?saddr=&daddr=\(self.currentDraft.locationLatitude),\(self.currentDraft.locationLongitude)"
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
    
    
    
    @IBAction func postToDatabase(_ sender: Any) {
    }
    
}



//MARK: Extension for collection view
extension DraftDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.needCollectionView) {
            return self.needs.count
        }
        else if (collectionView == self.schoolCollectionView) {
            return self.currentDraft.schoolImages.count
        }
        else {
            return self.currentDraft.roadImages.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.needCollectionView) {
            let cell = self.needCollectionView.dequeueReusableCell(withReuseIdentifier: "needCell", for: indexPath) as! NeedCollectionCell
            cell.myNeedsLabel.text = self.needs[indexPath.row].needsName
            if (self.parallel[indexPath.row] == true){
                cell.myNeedsLabel.backgroundColor = UIColor.cyan
            }
            else{
                cell.myNeedsLabel.backgroundColor = UIColor.gray
            }
            cell.myNeedsLabel.layer.borderColor = UIColor.black.cgColor
            cell.myNeedsLabel.layer.borderWidth = 1
            cell.myNeedsLabel.layer.cornerRadius = 3
            return cell
            
        }
        else if (collectionView == self.schoolCollectionView) {
            let cell = self.schoolCollectionView.dequeueReusableCell(withReuseIdentifier: "schoolCell", for: indexPath) as! ImageCollectionCell
            cell.setImage(image: self.currentDraft.schoolImages[indexPath.row])
            return cell
        }
        
        let cell = self.roadCollectionView.dequeueReusableCell(withReuseIdentifier: "roadCell", for: indexPath) as! ImageCollectionCell
        cell.setImage(image: self.currentDraft.roadImages[indexPath.row])
        print(indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.needCollectionView) {
            return CGSize(width: self.needCollectionView.frame.width/4-10, height: 20)
        }
        else if (collectionView == self.schoolCollectionView) {
            return CGSize(width: 65, height: 65)
        }
        else {
            return CGSize(width: 65, height: 65)
        }
    }
    
}
