//
//  MemeEditorViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/13/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

protocol MemeCreateViewControllerDelegate:class {
    func addMemeViewControllerDidCancel(_ controller: MemeCreateViewController)
    func addMemeViewController(_ controller:MemeCreateViewController, didFinishAdding item:Meme)
    func addMemeViewController(_ controller:MemeCreateViewController, didFinishEditing item:Meme)
    
}

class MemeCreateViewController: UIViewController, UITextFieldDelegate {
    
    weak var memeCreateViewControllerDelegate:MemeCreateViewControllerDelegate?
    
    var memeToEdit:Meme?

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var doneButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        if let meme = memeToEdit {
            title = meme.name
            nameTextField.text = meme.name
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            
        }
        doneButtonOutlet.isEnabled = true
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        memeCreateViewControllerDelegate?.addMemeViewControllerDidCancel(self)
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        
        if let memeToEdit = memeToEdit {
            memeToEdit.name = nameTextField.text!
            memeToEdit.topText = topTextField.text!
            memeToEdit.bottomText = bottomTextField.text!
            memeToEdit.image = "Burley"
            memeCreateViewControllerDelegate?.addMemeViewController(self, didFinishEditing: memeToEdit)
        } else {
            let meme = Meme()
            meme.name = nameTextField.text!
            meme.bottomText = bottomTextField.text!
            meme.topText = topTextField.text!
            
            memeCreateViewControllerDelegate?.addMemeViewController(self, didFinishAdding: meme)
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
