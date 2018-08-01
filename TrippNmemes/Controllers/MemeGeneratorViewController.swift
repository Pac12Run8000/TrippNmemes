//
//  MemeGeneratorViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/14/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit


protocol MemeGeneratorViewControllerDelegate:class {
    
    func memeGeneratorViewControllerDidCancel(_ controller:MemeGeneratorViewController)
    func memeGeneratorViewController(_ controller:MemeGeneratorViewController, didFinishAdding item:MemeObj)
    func memeGeneratorViewController(_ controller:MemeGeneratorViewController, didFinishEditing item:MemeObj)
    
}

class MemeGeneratorViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    
    var memeToEdit:MemeObj? 
    
    weak var memeGeneratorDelegate:MemeGeneratorViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        
        if let memeObj = memeToEdit {
            topTextField.text = memeObj.topText
            bottomTextField.text = memeObj.bottomText
            imageView.image = UIImage(data: memeObj.originalImage as Data)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButtonOutlet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setTextField(topTextField)
        setTextField(bottomTextField)
        subscribeToKeyboardNotifications()
        shareButtonOutlet.isEnabled = shouldButtonBeEnabledBasedOnImageView()
        
    }
    
    func shouldButtonBeEnabledBasedOnImageView() -> Bool {
        return imageView.image == nil ? false : true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        memeGeneratorDelegate?.memeGeneratorViewControllerDidCancel(self)
    }
    
    @IBAction func pickPhotoFromLibraray(_ sender: Any) {
        setImagePicker(type: .photoLibrary)
    }
    
    @IBAction func pickPhotoFromCamera(_ sender: Any) {
        setImagePicker(type: .camera)
    }
}

extension MemeGeneratorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setImagePicker(type: UIImagePickerControllerSourceType) {
        let pickerControl = UIImagePickerController()
        pickerControl.allowsEditing = true
        pickerControl.delegate = self
        pickerControl.sourceType = type
        present(pickerControl, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: This is for the add/remove keyboard functionality.
extension MemeGeneratorViewController {
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (bottomTextField.isEditing) {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if (bottomTextField.isEditing) {
           view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}

// MARK: This is for the textFields.
extension MemeGeneratorViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.backgroundColor = UIColor.white
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.backgroundColor = UIColor.clear
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setTextField(_ textField:UITextField) {
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -5
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        textField.delegate = self
    }
    

}

// MARK: This functionality is for creating a Meme
extension MemeGeneratorViewController {
    
    // MARK: Save function adds the meme the [MemeObj]
    func save(_ originalImageData:NSData, _ memedImage:NSData) {
        
        // Note: var myMeme:MemeObj?
        // myMeme = MemeObj(coreDataStack.viewContext)
        
        if let memeToEdit = memeToEdit {
            memeToEdit.topText = topTextField.text!
            memeToEdit.bottomText = bottomTextField.text!
            memeToEdit.originalImage = UIImagePNGRepresentation(imageView.image!)! as NSData
            memeToEdit.memedImage = memedImage
            memeGeneratorDelegate?.memeGeneratorViewController(self, didFinishEditing: memeToEdit)
        } else {
            let memeToAdd = MemeObj(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: originalImageData, memedImage: memedImage as NSData)
                memeGeneratorDelegate?.memeGeneratorViewController(self, didFinishAdding: memeToAdd)
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let myCustomMeme = generateMemedImage(self)
        let avc = UIActivityViewController(activityItems: [myCustomMeme], applicationActivities: nil)
        present(avc, animated: true, completion: nil)
        avc.completionWithItemsHandler = {
            activity, completion, items, err in
            if completion {
                if let originalImageData = UIImagePNGRepresentation(self.imageView.image!) {
                    self.save(originalImageData as NSData, myCustomMeme)
                } else {
                    print("There is no selected image.")
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: This static function creates the memed image
    func generateMemedImage(_ controller:UIViewController) -> NSData {
        UIGraphicsBeginImageContext(controller.view.frame.size)
        controller.view.drawHierarchy(in: controller.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return UIImagePNGRepresentation(memedImage)! as NSData
    }
    
    

    
}
