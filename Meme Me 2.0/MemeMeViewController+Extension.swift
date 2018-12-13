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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: Screen manipulation methods, to move the UIView up when the bottom text field is editing.
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y =  getKeyboardHeight(notification) * -1
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    //MARK: Value returning method to calculate keyboard height.
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}
