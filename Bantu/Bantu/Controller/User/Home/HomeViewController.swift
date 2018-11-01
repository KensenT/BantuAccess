//
//  HomeViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var eventsTableView: UITableView!
    
    var events: [Event] = []
    var filteredEvents: [Event] = []
    
    var sizeFilteredEvents: [CGFloat] = []
    var sizeEvents: [CGFloat] = []
    
    var selectedEvent: Event!
    var searching = false
//
//    var size: CGFloat = 0
    
//    @IBAction func shareButtonTapped(_ sender: Any) {
//        let buttonPosition : CGPoint = (sender as AnyObject).convert(CGPoint.zero, to: self.tableView)
//        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
//        let sharedTitle = [eventTitles[(indexPath?.last)!]]
//
//        let activityController = UIActivityViewController(activityItems: sharedTitle, applicationActivities: nil)
//
//        self.present(activityController, animated: true, completion: nil)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        AddDraft.selectedIndex = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.resultController.tableView.dataSource = self
        self.resultController.tableView.delegate = self
        
        self.setNeeds()
        self.getEvents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.setDynamicTable), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc func setDynamicTable(){
        self.eventsTableView.reloadData()
        print("size changed")
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    func getEvents(){
        EventServices.getEvents(){ (events) in
            self.events = events
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
    func setNeeds(){
        let fetchRequest: NSFetchRequest<NeedsEntity> = NeedsEntity.fetchRequest()
        do{
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            let tempResult = fetchData
            
            var tempNeeds: [Needs] = []
            
            // x as each row in entity
            for x in tempResult{
                let needsId = Int(x.needsId)
                let needsName: String = x.needsName!
                
                let newNeeds: Needs = Needs(needsId: needsId, needsName: needsName)
                
                tempNeeds.append(newNeeds)
            }
            print("fetch successful")
            AddDraft.needs = tempNeeds
            
        } catch {}
        
        NeedsServices.getNeeds { (needs) in
            if (needs.count != 0){
                for singleNeed in needs{
                    var found: Bool = false
                    for currNeed in AddDraft.needs{
                        if (singleNeed.needsId == currNeed.needsId){
                            found = true
                            break
                        }
                    }
                    if (found == false){
                        AddDraft.needs.append(singleNeed)
                        self.saveNeedsToCoreData(needs: singleNeed)
                    }
                }
            }
            print(AddDraft.needs)
        }
    }
    
    func saveNeedsToCoreData(needs: Needs){
        let tempNeeds = NeedsEntity(context: LocalServices.context)
        
        tempNeeds.needsId = Int64(needs.needsId)
        tempNeeds.needsName = needs.needsName
        
        LocalServices.saveContext()
    }
    
    var searchController: UISearchController!
    var resultController = UITableViewController()
    
    func setupNavBar() {
//        self.searchController = UISearchController(searchResultsController: self.resultController)
//        self.tableView.tableHeaderView = self.searchController.searchBar
//        self.searchController.searchResultsUpdater = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"user-4"), style: .plain, target: self, action: #selector(profileTapped))
    }
    
    @objc func profileTapped() {
        performSegue(withIdentifier: "homeToLog", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "userEventToDetail"){
            let destination = segue.destination as! EventDetailViewController
            destination.currentEvent = self.selectedEvent
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true {
            return self.filteredEvents.count
        } else {
            return self.events.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        if searching == true {
            cell.setCell(event: self.filteredEvents[indexPath.row])
            
        } else {
            cell.setCell(event: self.events[indexPath.row])
        }
        
        var k: CGFloat = cell.eventImageView.frame.height + 40
        k = k + cell.eventTitleLabel.font.lineHeight*3
        
        cell.eventTitleLabel.frame = CGRect(x: cell.eventTitleLabel.frame.origin.x, y: cell.eventTitleLabel.frame.origin.y, width: cell.eventTitleLabel.frame.width, height: cell.eventTitleLabel.font.lineHeight + 10)
        
        cell.dateLabel.frame = CGRect(x: cell.dateLabel.frame.origin.x, y: cell.eventTitleLabel.frame.origin.y + cell.eventTitleLabel.font.lineHeight + 10, width: cell.dateLabel.frame.width, height: cell.dateLabel.font.lineHeight + 10)
        
        cell.locationLabel.frame = CGRect(x: cell.locationLabel.frame.origin.x, y: cell.dateLabel.frame.origin.y + cell.dateLabel.font.lineHeight + 10, width: cell.locationLabel.frame.width, height: cell.locationLabel.font.lineHeight + 10)
        
        cell.calendarIcon.frame = CGRect(x: cell.calendarIcon.frame.origin.x, y: cell.dateLabel.frame.origin.y + cell.dateLabel.font.lineHeight/2, width: cell.calendarIcon.frame.width, height: cell.calendarIcon.frame.height)
        
        cell.locationIcon.frame = CGRect(x: cell.locationIcon.frame.origin.x, y: cell.locationLabel.frame.origin.y + cell.locationLabel.font.lineHeight/2, width: cell.locationIcon.frame.width, height: cell.locationIcon.frame.height)
        
        self.eventsTableView.rowHeight = k
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (searching == true){
            self.selectedEvent = self.filteredEvents[indexPath.row]
        }
        else{
            self.selectedEvent = self.events[indexPath.row]
        }
        performSegue(withIdentifier: "userEventToDetail", sender: self)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return k
//    }
    
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredEvents = self.events.filter({$0.eventName.lowercased().contains(searchText.lowercased())})
        if searchText == ""{
            self.filteredEvents = self.events
        }
        searching = true
        self.eventsTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.eventsTableView.reloadData()
        self.becomeFirstResponder()
    }
}
