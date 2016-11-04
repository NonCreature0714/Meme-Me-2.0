//
//  MemeMeViewController.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/9/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: IBOutlet(s).
    @IBOutlet weak var imagePickedView: UIImageView!
    @IBOutlet weak var cameraPickerButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    @IBOutlet weak var pickerToolbar: UIToolbar!
    @IBOutlet weak var cancelToolbarButton: UIBarButtonItem!
    @IBOutlet weak var shareOrCancelToolbar: UIToolbar!
    
    
    //MARK: Member(s)
    var meme = Meme()
    enum SourceSelection{ case album, camera }
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSStrokeWidthAttributeName: -5.0,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        ] as [String : Any]
    var memed: UIImage?
    let topTextFieldDelegate = TopTextFieldDelegate()
    let bottomTextFieldDelegate = BottomTextFieldDelegate()
    
    //MARK: Overriden UIViewController methods.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraPickerButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        subcribeToKeyboardNotifications()
        super.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
        super.tabBarController?.tabBar.isHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        configureUI()
        reset()
        super.tabBarController?.tabBar.isHidden = true
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK: IBActions.
    @IBAction func pickImage(_ sender: AnyObject) {
        
        let  controller = UIImagePickerController()
        controller.delegate = self
        
        switch sender.tag {
        case 0:
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        case 1:
            controller.sourceType = UIImagePickerControllerSourceType.camera
        default:
            let alertController = UIAlertController()
            alertController.title = "Meme Me Error"
            alertController.message = "There was an error while choosing an image."
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion: nil)})
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
        
        present(controller, animated: true, completion: {
            ACTION in controller.prefersStatusBarHidden
        })
        
        shareButton.isEnabled = true
    }
    
    //MARK: IBActions
    @IBAction func shareMeme(_ sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { type, completed, returnedItems, error -> Void in
            if completed {
                self.save()
            }
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme(_ sender: AnyObject) {
        reset()
    }
    
    
    //MARK: UIImagePickerDelegate methods.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickedView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UIConfiguration methods.
    private func configureUI() {
        configureText(topTextField)
        configureText(bottomTextField)
        hideShare(true)
    }
    
    private func configureText(_ textField: UITextField){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        switch textField.tag {
        case 0:
            textField.text = "TOP"
        case 1:
            textField.text = "BOTTOM"
        default:
            textField.text = "ERROR"
            let alertController = UIAlertController()
            alertController.title = "Meme Me Error"
            alertController.message = "There was an error while configuring the app."
            let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion: nil)})
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
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
