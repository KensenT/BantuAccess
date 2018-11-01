//
//  StringExtension.swift
//  Bantu
//
//  Created by Steven Muliamin on 16/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

extension String{
    func beautifyDate() -> String{
        let months: [String] = [
            "Januari", "Februari", "Maret", "April", "May", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"
        ]
        
        var x = self.components(separatedBy: "-")
        x[1] = months[Int(x[1])!-1]
        return x.joined(separator: " ")
    }
}
