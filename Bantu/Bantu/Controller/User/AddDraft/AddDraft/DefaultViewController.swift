//
//  DefaultViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (AddDraft.onDraft == false){
            AddDraft.onDraft = true
            performSegue(withIdentifier: "defaultSegue", sender: nil)
        }
        else{
            AddDraft.onDraft = false
            self.tabBarController?.selectedIndex = AddDraft.selectedIndex
        }
        
    }
    
    
    
}
