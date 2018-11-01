//
//  EventViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 12/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var eventsTableView: UITableView!
    
    var events: [Event] = []
    
    var selectedEvent: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getEvents()
    }
    
    func getEvents(){
        EventServices.getEvents(){ (events) in
            self.events = events
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
    
    @IBAction func addEventTapped(_ sender: Any) {
        performSegue(withIdentifier: "eventToAddEvent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "adminEventToDetail"){
            let destination = segue.destination as! AdminEventDetailViewController
            destination.currentEvent = self.selectedEvent
        }
    }
}

extension EventViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminHomeCell") as! HomeCell
        cell.setCell(event: self.events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedEvent = self.events[indexPath.row]
        performSegue(withIdentifier: "adminEventToDetail", sender: self)
    }
    
    
}
