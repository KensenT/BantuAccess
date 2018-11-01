//
//  PaddingTextField.swift
//  
//
//  Created by Resky Javieri on 08/10/18.
//

import UIKit

extension UITextField {
    
    func setIndentLeftPadding() {
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}
