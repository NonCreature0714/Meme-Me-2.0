//
//  MemeMeViewController.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/9/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: IBOutlet(s).
    @IBOutlet weak var imagePickedView: UIImageView!
    @IBOutlet weak var cameraPickerButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelToolbarButton: UIBarButtonItem!
    
    @IBOutlet weak var pickerToolbar: UIToolbar!
    @IBOutlet weak var shareOrCancelToolbar: UIToolbar!
    
    
    //MARK: Member(s)
    var meme = Meme()
        let memeTextAttributes = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.strokeColor) : UIColor.black,
        convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor) : UIColor.white,
        convertFromNSAttributedStringKey(NSAttributedString.Key.strokeWidth): -5.0,
        convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "Impact", size: 40)!,
        ] as [String : Any]
    var memed: UIImage?
    
    
    //MARK: Overriden UIViewController methods.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        subcribeToKeyboardNotifications()
        super.tabBarController?.tabBar.isHidden = true
        shareOrCancelToolbar.updateConstraints()
        super.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
        super.tabBarController?.tabBar.isHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        configureUI()
        reset()
        super.tabBarController?.tabBar.isHidden = true
    }
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: IBActions.
    @IBAction func pickImage(_ sender: AnyObject) {
        
        let  controller = UIImagePickerController()
        controller.delegate = self
        
        switch sender.tag {
        case 0:
            controller.sourceType = UIImagePickerController.SourceType.photoLibrary
        case 1:
            controller.sourceType = UIImagePickerController.SourceType.camera
        default:
            let alertController = UIAlertController()
            alertController.title = "Meme Me Error"
            alertController.message = "There was an error while choosing an image."
            let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: {action in self.dismiss(animated: true, completion: nil)})
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
        present(controller, animated: true, completion: nil)
        //MARK: Really want to know how to hide the status bar in imagepicker view. How to do this changed in Swift 3.
        
        shareButton.isEnabled = true
    }
    
    //MARK: IBActions
    @IBAction func shareMeme(_ sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { type, completed, returnedItems, error -> Void in
            if completed {
                self.cancelToolbarButton.title = "Done"
                self.save()
            }
        }
        
        
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UIImagePickerDelegate methods.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            imagePickedView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate methods.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        let textSize: CGSize = newText.size(withAttributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): textField.font!]))
        return textSize.width < textField.bounds.size.width
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text! == "TOP" || textField.text! == "BOTTOM" {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: UIConfiguration methods.
    private func configureUI() {
        configureText(topTextField, "TOP")
        configureText(bottomTextField, "BOTTOM")
        hideShare(true)
    }
    
    private func configureText(_ textField: UITextField, _ text: String){
        textField.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(memeTextAttributes)
        textField.textAlignment = NSTextAlignment.center
        textField.text = text
    }
    
    private func hideUIElements(_ hide: Bool) {
        pickerToolbar.isHidden = hide
        hideShare(hide)
        shareOrCancelToolbar.isHidden = hide
    }
    
    
    //MARK: Meme generation supporting methods.
    private func generateMemedImage() -> UIImage
    {
        hideUIElements(true)
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideUIElements(false)
        memed = memedImage
        
        return memedImage
    }
    
    private func hideShare(_ hide: Bool){
        shareButton.isEnabled = !hide
    }
    
    private func save() {
        meme = Meme(topTextField: topTextField.text, bottomTextField: bottomTextField.text, originalImage: imagePickedView.image, memedImage: memed)
        
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)        
    }
    
    private func reset(){
        imagePickedView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
