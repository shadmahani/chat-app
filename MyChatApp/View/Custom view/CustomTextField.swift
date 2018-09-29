//
//  CustomTextField.swift
//  MyChatApp
//
//  Created by hossein shademany on 4/14/1397 AP.
//  Copyright © 1397 hossein shademany. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    
    
    private var maxLengths = [UITextField: Int]()
   
        @IBInspectable var maxLength: Int {
            get {
                guard let l = maxLengths[self] else {
                    return 150 // (global default-limit. or just, Int.max)
                }
                return l
            }
            set {
                maxLengths[self] = newValue
                addTarget(self, action: #selector(fix), for: .editingChanged)
            }
        }
    @objc func fix(textField: UITextField) {
            let t = textField.text
            textField.text = t?.safelyLimitedTo(length: maxLength)
        }
   
}
extension String{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}
