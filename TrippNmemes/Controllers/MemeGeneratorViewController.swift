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
    
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    weak var memeGeneratorDelegate:MemeGeneratorViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = .scaleAspectFill
        
        if let memeObj = memeToEdit {
            topTextField.text = memeObj.topText
            bottomTextField.text = memeObj.bottomText
            imageView.image = memeObj.originalImage
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
//        navigationController?.popViewController(animated: true)
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
    
    
//    if let memeToEdit = memeToEdit {
//        memeToEdit.memedImage = nameTextField.text!
//        memeToEdit.topText = topTextField.text!
//        memeToEdit.bottomText = bottomTextField.text!
//        memeToEdit.originalImage = "Burley"
//        memeCreateViewControllerDelegate?.addMemeViewController(self, didFinishEditing: memeToEdit)
//    } else {
//    let meme = Meme()
//    meme.memedImage = nameTextField.text!
//    meme.bottomText = bottomTextField.text!
//    meme.topText = topTextField.text!
//
//    memeCreateViewControllerDelegate?.addMemeViewController(self, didFinishAdding: meme)
//
//    navigationController?.popViewController(animated: true)
//    }
    
    
    // MARK: Save function adds the meme the [MemeObj]
    func save(_ originalImage:UIImage, _ memedImage:UIImage) {
        
        if let memeToEdit = memeToEdit {
            memeToEdit.topText = topTextField.text!
            memeToEdit.bottomText = bottomTextField.text!
            memeToEdit.originalImage = imageView.image!
            memeToEdit.memedImage = memedImage
            memeGeneratorDelegate?.memeGeneratorViewController(self, didFinishEditing: memeToEdit)
        } else {
            let generatedMeme = MemeObj(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: originalImage, memedImage: memedImage)
            memeGeneratorDelegate?.memeGeneratorViewController(self, didFinishAdding: generatedMeme)
        }
        
        
//        appdelegate.memeObjArray?.append(generatedMeme)
        
//        for item in appdelegate.memeObjArray! {
//            print("toptext: \(item.topText), count: \(String(describing: appdelegate.memeObjArray?.count))")
//        }
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let myCustomMeme = MemeObj.generateMemedImage(self)
        let avc = UIActivityViewController(activityItems: [myCustomMeme], applicationActivities: nil)
        present(avc, animated: true, completion: nil)
        avc.completionWithItemsHandler = {
            activity, completion, items, err in
            if completion {
                if let originalImage = self.imageView.image {
                    self.save(originalImage, myCustomMeme)
                } else {
                    print("There is no selected image.")
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    

    
}
