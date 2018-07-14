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
    func addMemeViewControllere(_ controller:MemeCreateViewController, didFinishAdding item:Meme)
}

class MemeCreateViewController: UIViewController, UITextFieldDelegate {
    
    weak var memeCreateViewControllerDelegate:MemeCreateViewControllerDelegate?
    
    

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
        // Do any additional setup after loading the view.
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
        let meme = Meme()
        meme.name = nameTextField.text!
        meme.bottomText = bottomTextField.text!
        meme.topText = topTextField.text!
        
        memeCreateViewControllerDelegate?.addMemeViewControllere(self, didFinishAdding: meme)

        navigationController?.popViewController(animated: true)
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
