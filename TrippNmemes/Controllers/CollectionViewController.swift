//
//  CollectionViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MemeGeneratorViewControllerDelegate {
    
    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishAdding item: (topText: String, bottomText: String, originalImage: NSData, memedImage: NSData)) {
        addMeme(item: item)
        navigationController?.popViewController(animated: true)
    }
    
    
    func memeGeneratorViewControllerDidCancel(_ controller: MemeGeneratorViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func memeGeneratorViewController(_ controller: MemeGeneratorViewController, didFinishEditing item: MemeObj) {
        editMeme(item: item)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addBarButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayoutSetUp()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    @IBAction func deleteSelected() {
        deleteMemes()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        deleteBarButton.isEnabled = editing
        addBarButtonOutlet.isEnabled = !editing
        
        collectionView.allowsMultipleSelection = editing
        
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes {
            let cell = collectionView.cellForItem(at: index) as! CustomCollectionViewCell
            cell.isEditing = editing
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return CoreDataStack.sharedInstance().memeObjArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = CoreDataStack.sharedInstance().memeObjArray[(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.isEditing = isEditing
        cell.memeObj = meme
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            print("boxer name:\(CoreDataStack.sharedInstance().memeObjArray[indexPath.row].memedImage)")
        }
    }
    
    // MARK: stops collectionView from performing segue in isEditing Mode
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing {
            return false
        }
        return true
    }
}

// MARK: The functionality for adding, editing, deleting memes in CoreData
extension CollectionViewController {
    // MARK: Add a meme
    func addMeme(item:(topText:String, bottomText:String, originalImage:NSData, memedImage:NSData)) {
        let addedMeme = MemeObj(topText: item.topText, bottomText: item.bottomText, originalImage: item.originalImage, memedImage: item.memedImage)
        CoreDataStack.sharedInstance().memeObjArray.append(addedMeme)
    }
    
    // MARK: Edit a meme
    func editMeme(item:MemeObj) {
        if let index = CoreDataStack.sharedInstance().memeObjArray.index(of: item) {
            let memeObj = CoreDataStack.sharedInstance().memeObjArray[index]
            memeObj.topText = item.topText
            memeObj.bottomText = item.bottomText
            memeObj.originalImage = item.originalImage
            memeObj.memedImage = item.memedImage
        }
    }
    
    // MARK: Delete memes
    func deleteMemes() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                CoreDataStack.sharedInstance().memeObjArray.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
    }
    
}

// MARK: This is the prepareForSegue functionality
extension CollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCollectionView" {
            let controller = segue.destination as! MemeGeneratorViewController
            controller.memeGeneratorDelegate = self
        } else if segue.identifier == "EditCollectionView" {
            let controller = segue.destination as! MemeGeneratorViewController
            controller.memeGeneratorDelegate = self
            if let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell) {
                controller.memeToEdit = CoreDataStack.sharedInstance().memeObjArray[indexPath.row]
            }
        }
    }
    
}


// MARK: Setup the flowlayout
extension CollectionViewController {
    
    func flowLayoutSetUp() {
        // You get the - 20 from the min spacing for cells in your size attributes for collectionView
        //        let width = (view.frame.size.width - 20) / 3
        //        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        layout.itemSize = CGSize(width: width, height: width)
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
}
