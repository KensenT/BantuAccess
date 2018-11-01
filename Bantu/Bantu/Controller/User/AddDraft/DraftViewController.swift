//
//  DraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreData


class DraftViewController: UIViewController {
    
    
    //MARK: Outlet for tableview
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Array Declaration
    var draftArray: [Post] = []
    var tempResult: [DraftEntity] = []
    
    
    //MARK: Variable Declaration
    var currentDraft: Post!
    var selectedDraftIndex: Int!
    var isNewDraft: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        AddDraft.selectedIndex = 2
        
        self.draftArray.removeAll()
        self.fetchFromCoreData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDraftDetail" {
            let destination = segue.destination as! DraftDetailViewController
            destination.currentDraft = self.currentDraft
        }
    }
    
    
    func fetchFromCoreData() {
        
        let fetchRequest: NSFetchRequest<DraftEntity> = DraftEntity.fetchRequest()
        do{
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            self.tempResult = fetchData
            
            for x in self.tempResult {
                var tempNeeds: [Needs] = []
                var tempSchool: [UIImage] = []
                var tempRoad: [UIImage] = []
                
                // Converting [[String:Any]] to Needs
                for singleNeed in x.needsPost! {
                    let needsId = singleNeed["needsId"] as! Int
                    let needsName = singleNeed["needsName"] as! String
                    let newNeed = Needs(needsId: needsId, needsName: needsName)
                    tempNeeds.append(newNeed)
                }
                
                
                // Get School Images
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: x.schoolImages as! Data) as? NSArray {
                    for i in 0..<mySavedData.count {
                        let image = UIImage(data: mySavedData[i] as! Data)
                        tempSchool.append(image!)
                    }
                }
                
                
                // Get Road Images
                if let mySavedData = NSKeyedUnarchiver.unarchiveObject(with: x.roadImages as! Data) as? NSArray {
                    for i in 0..<mySavedData.count {
                        let image = UIImage(data: mySavedData[i] as! Data)
                        tempRoad.append(image!)
                    }
                }
                
                self.draftArray.append(Post(postId: 0, userId: 0, statusId: 0, timeStamp: x.timeStamp!, schoolName: x.schoolName!, about: x.aboutPost!, studentNo: Int(x.studentNo), teacherNo: Int(x.teacherNo), address: x.addressPost!, access: x.accessPost!, notes: x.notesPost!, locationAOI: x.locationAOI!, locationName: x.locationName!, locationLocality: x.locationLocality!, locationAdminArea: x.locationAdminArea!, locationLatitude: x.locationLatitude, locationLongitude: x.locationLongitude, fullName: "", statusName: "", schoolImages: tempSchool, roadImages: tempRoad, needs: tempNeeds))
            }
            
            print("Fetch from core data successful")
            self.tableView.reloadData()
            
        } catch {
            print("Fetch from core data fail")
        }
    }
    
    
    //MARK: Function to delete specific index from core data
    func deleteFromCoreData(index: Int) {
        
        self.draftArray.remove(at: index)
        
        let managedContext = LocalServices.persistentContainer.viewContext
        let node = self.tempResult[index]
        managedContext.delete(node)
        
        do{
            try managedContext.save()
            print("Delete Success")
        } catch let error as NSError{
            print("Error while deleting node: \(error.userInfo)")
        }
    }
    
}


//MARK: Extension for table view
extension DraftViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.draftArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let draftCell = self.tableView.dequeueReusableCell(withIdentifier: "draftCell", for: indexPath) as! DraftCell
        
        draftCell.dateLabel.text = self.draftArray[indexPath.row].timeStamp
        draftCell.schoolNameLabel.text = self.draftArray[indexPath.row].schoolName
        draftCell.accessoryType = .disclosureIndicator
        
        return draftCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentDraft = self.draftArray[indexPath.row]
        self.selectedDraftIndex = indexPath.row
        print("Indexpath = \(indexPath.row)")
        self.performSegue(withIdentifier: "segueToDraftDetail", sender: self)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteFromCoreData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
