//
//  TopTextFieldDelegate.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 11/1/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    //MARK: Member(s)
    let topTextField = "TOP"
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        let textSize: CGSize = newText.size(attributes: [NSFontAttributeName: textField.font!])
        return textSize.width < textField.bounds.size.width
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        var text = textField.text
        
        if text == topTextField {
            text = ""
        }
        
        textField.text = text
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField.text == "" {
            textField.text = topTextField
        }
        
        return true
    }
    
    
}
