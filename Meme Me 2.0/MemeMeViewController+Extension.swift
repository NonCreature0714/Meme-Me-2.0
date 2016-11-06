//
//  MemeMeViewController+Extension.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/9/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

extension MemeMeViewController {
    
    //MARK: Subscribing/Unsubribing to NotificationCenter.
    func subcribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    //MARK: Screen manipulation methods, to move the UIView up when the bottom text field is editing.
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y =  getKeyboardHeight(notification) * -1
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    //MARK: Value returning method to calculate keyboard height.
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}
