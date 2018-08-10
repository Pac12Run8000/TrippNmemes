//
//  ViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MemeGeneratorViewControllerDelegate {
    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishAdding item: (topText: String, bottomText: String, originalImage: NSData, memedImage: NSData)) {
        addMeme(item: item)
        navigationController?.popViewController(animated: true)
    }
    
    
    func memeGeneratorViewControllerDidCancel(_ controller: MemeGeneratorViewController) {
        navigationController?.popViewController(animated: true)
    }

//    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishAdding item: MemeObj) {
//        addMeme(item: item)
//        navigationController?.popViewController(animated: true)
//    }
    
    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishEditing item: MemeObj) {
        editMeme(item: item)
        navigationController?.popViewController(animated: true)
    }
    


    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
//        for item in delegate.memeObjArray! {
//            print("meme: \(item.topText)\n")
//        }
//
//        print("count:\(String(describing: delegate.memeObjArray?.count))")
        // Test if meme is equatable
//        print(delegate.memeArray![0] == delegate.memeArray![3])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteMeme(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            ()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return CoreDataStack.sharedInstance().memeObjArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.memeObj = CoreDataStack.sharedInstance().memeObjArray[(indexPath as NSIndexPath).row]
        return cell
    }
}



// MARK: This is the add, edit and delete functionality
extension TableViewController {
    
    
    // MARK: deletion of memes
    func deleteMeme(indexPath:IndexPath) {
        CoreDataStack.sharedInstance().memeObjArray.remove(at: indexPath.row)
    }
    
    // MARK: adding a meme
    func addMeme(item:(topText:String, bottomText:String, originalImage:NSData, memedImage:NSData)) {
        let addedMeme = MemeObj(topText: item.topText, bottomText: item.bottomText, originalImage: item.originalImage, memedImage: item.memedImage)
        CoreDataStack.sharedInstance().memeObjArray.append(addedMeme)
    }
    
    // MARK: editing a meme
    func editMeme(item:MemeObj) {
        if let index = CoreDataStack.sharedInstance().memeObjArray.index(of: item) {
            let memeObj = CoreDataStack.sharedInstance().memeObjArray[index]
            memeObj.topText = item.topText
            memeObj.bottomText = item.bottomText
            memeObj.originalImage = item.originalImage
            memeObj.memedImage = item.memedImage
        }
    }
    
    
}



// MARK: This is where the prepareForSegue functionality is
extension TableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTableView" {
            let controller = segue.destination as! MemeGeneratorViewController
            controller.memeGeneratorDelegate = self
        } else if segue.identifier == "EditTableView" {
            let controller = segue.destination as! MemeGeneratorViewController
            controller.memeGeneratorDelegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.memeToEdit = CoreDataStack.sharedInstance().memeObjArray[indexPath.row]
            }
        }
    }
    
}

// Meme Equatable definition syntax
//extension TableViewController {}
//
//func ==(lhs: Meme, rhs: Meme) -> Bool {
//    return lhs.topText == rhs.topText
//}

