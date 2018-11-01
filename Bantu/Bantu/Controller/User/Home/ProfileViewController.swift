//
//  ProfileViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet var profileTableView: UITableView!
    @IBOutlet weak var fullNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileTableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (GlobalSession.isLoggedIn == true){
            self.fullNameLabel.text = GlobalSession.loggedInUser.fullName
        }
        else{
            self.fullNameLabel.text = ""
        }
        
        if (GlobalSession.isLoggedIn == false){
            performSegue(withIdentifier: "profileToLog", sender: self)
        }
        else{
            if (GlobalSession.loggedInUser.levelId == 1){
                performSegue(withIdentifier: "profileToAdmin", sender: self)
            }
            else{
                if (GlobalSession.initialLogin == true){
                    GlobalSession.initialLogin = false
                    PostServices.getPostsByUser(){ (posts) in
                        GlobalSession.submissions = posts
                    }
                }
            }
        }
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout of this account?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Logout", style: .default) { (UIAlertAction) in
            GlobalSession.isLoggedIn = false
            GlobalSession.loggedInUser = nil
            GlobalSession.initialLogin = true
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
