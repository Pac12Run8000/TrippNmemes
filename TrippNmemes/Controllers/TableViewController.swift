//
//  ViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        delegate.memeArray = Meme.MemesArray
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        
        // Test if meme is equatable
//        print(delegate.memeArray![0] == delegate.memeArray![3])
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            delegate.memeArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            ()
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let memeArray = delegate.memeArray {
            return memeArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        if let memes = delegate.memeArray {
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

