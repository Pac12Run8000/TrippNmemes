//
//  ViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MemeGeneratorViewControllerDelegate {
    
    
    
    func memeGeneratorViewControllerDidCancel(_ controller: MemeGeneratorViewController) {
        navigationController?.popViewController(animated: true)
    }

    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishAdding item: MemeObj) {
        delegate.memeObjArray?.append(item)
        navigationController?.popViewController(animated: true)
    }
    
    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishEditing item: MemeObj) {
        if let index = delegate.memeObjArray?.index(of: item) {
            let memeObj = delegate.memeObjArray![index]
            memeObj.topText = item.topText
            memeObj.bottomText = item.bottomText
            memeObj.originalImage = item.originalImage
            memeObj.memedImage = item.memedImage
        }
        navigationController?.popViewController(animated: true)
    }
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTableView" {
            let controller = segue.destination as! MemeGeneratorViewController
            controller.memeGeneratorDelegate = self
        } else if segue.identifier == "EditTableView" {
            let controller = segue.destination as! MemeGeneratorViewController
            controller.memeGeneratorDelegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.memeToEdit = delegate.memeObjArray?[indexPath.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            delegate.memeObjArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            ()
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let memeArray = delegate.memeObjArray {
            return memeArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        if let memes = delegate.memeObjArray {
            let meme = memes[(indexPath as NSIndexPath).row]

            cell.memeObj = meme

        }
        return cell
    }
    


}

// Meme Equatable definition syntax
//extension TableViewController {}
//
//func ==(lhs: Meme, rhs: Meme) -> Bool {
//    return lhs.topText == rhs.topText
//}

