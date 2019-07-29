//
//  ViewController.swift
//  meme-1
//
//  Created by Wael Yazqi on 2019-04-08.
//  Copyright © 2019 Wael. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate  {

// Out Let
    @IBOutlet weak var imagepicker: UIImageView!

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var Toptext: UITextField!
    @IBOutlet weak var Bottomtext: UITextField!
    
    @IBOutlet weak var sharebutton: UIBarButtonItem!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var navbar: UINavigationBar!
    
//View didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
// Disable share Button
    sharebutton.isEnabled = false
        
// delegation
   Toptext.delegate = self
   Bottomtext.delegate = self
        
//Text alignement ,text and DTA
configureTextField(Toptext, text: "TOP")
   configureTextField(Bottomtext, text: "BOTTOM")
    }
    
// Text attributes Charecterstics
    
// Text Configuration
    
    func configureTextField(_ textField: UITextField, text: String) {
        textField.text = text
        textField.delegate = self
        textField.defaultTextAttributes = [
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .foregroundColor: UIColor.white,
            .strokeColor: UIColor.black,
            .strokeWidth: -3.0 ]
        textField.textAlignment = .center
    }
    
// view will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
    }
    
// View will disappear
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
            }
    
//  Selecting image Function
    
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
{
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        imagepicker.contentMode = .scaleAspectFit
        imagepicker.image = image
        sharebutton.isEnabled = true
    }
    picker.dismiss(animated: true, completion: nil)
}

//
    func pickAnImage(_ source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }

// pick an image from Camera
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
pickAnImage(UIImagePickerController.SourceType.camera)
    }
// pick an image from Album
    
    @IBAction func Pickanimagefromalbum(_ sender: Any) {
pickAnImage(UIImagePickerController.SourceType.photoLibrary)
    }
    


// Key Board
    // keyboard should be dismissed after return Pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    Toptext.resignFirstResponder()
     Bottomtext.resignFirstResponder()
        return true
    }
    
// Keyboard keyboardWillShow
    @objc func keyboardWillShow(_ notification:Notification) {
        if Bottomtext.isEditing
        {view.frame.origin.y = -getKeyboardHeight(notification)}
    }
    
// Keyboard keyboardWillHide
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if Bottomtext.isEditing{
        view.frame.origin.y = 0
        }
    }
    
// Idenify getKeyboardHeight

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
// Subscribe Function

    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

// UnSubscribe Function
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
     NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
          }
    
    
// the toolbar and navbar & Rander image
    
    func generateMemedImage() -> UIImage {
        
   //navbar.isHidden = true
        toolbar.isHidden = true
   
        // Render view to an image
        UIGraphicsBeginImageContext(self.imagepicker.frame.size)
        view.drawHierarchy(in: self.imagepicker.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
  // navbar.isHidden = true
   toolbar.isHidden = false
 
        return memedImage
    }
// Initializing a Meme object
    
    func save() {
        // Create the meme
        let memedImagesaved = generateMemedImage()
        let meme = Meme(topTextField: Toptext.text!, bottomTextField: Bottomtext.text!, originalImage: imagepicker.image!, memedImage: memedImagesaved)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }

// share button Activity
    @IBAction func share(_ sender: Any) {
        let memeShare = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memeShare], applicationActivities: nil)
        

    activityViewController.completionWithItemsHandler = { Activity, completed, items, error -> Void in
              if completed {
                 self.save()
                self.dismiss(animated: true, completion: nil)
       }
 }
        
     present(activityViewController, animated: true, completion: nil)
    }
        
    
//  CANCEL BUTTON

    @IBAction func cancelbutton(_ sender: Any) {
        Toptext.text = "TOP"
        Bottomtext.text = "BOTTOM"
        self.imagepicker.image = nil
        dismiss(animated: true, completion: nil)
    // Back to Root view controller
        
navigationController?.popToRootViewController(animated: true)
        
    }
    
}
