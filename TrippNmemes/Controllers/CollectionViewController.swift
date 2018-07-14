//
//  CollectionViewController.swift
//  TrippNmemes
//
//  Created by Michelle Grover on 7/9/18.
//  Copyright © 2018 Norbert Grover. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MemeCreateViewControllerDelegate {
    func addMemeViewControllerDidCancel(_ controller: MemeCreateViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addMemeViewController(_ controller: MemeCreateViewController, didFinishAdding item: Meme) {
        delegate.memeArray?.append(item)
        print("item:\(item.name)")
        navigationController?.popViewController(animated: true)
    }
    
    func addMemeViewController(_ controller: MemeCreateViewController, didFinishEditing item: Meme) {
        if let index = delegate.memeArray?.index(of: item) {
            let meme = delegate.memeArray![index]
            meme.name = item.name
            meme.image = item.image
            meme.bottomText = item.bottomText
            meme.topText = item.topText
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addBarButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayoutSetUp()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func deleteSelected() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map { $0.item }.sorted().reversed()
            for item in items {
                delegate.memeArray?.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
        }
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
        return delegate.memeArray!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = delegate.memeArray![(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.isEditing = isEditing
        cell.memeObj = meme
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            print("boxer name:\(delegate.memeArray![indexPath.row].name)")
        }
    }
    // MARK: stops collectionView from performing segue in isEditing Mode
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing {
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCollectionView" {
            let controller = segue.destination as! MemeCreateViewController
            controller.memeCreateViewControllerDelegate = self
        } else if segue.identifier == "EditCollectionView" {
            let controller = segue.destination as! MemeCreateViewController
            controller.memeCreateViewControllerDelegate = self
            if let indexPath = collectionView.indexPath(for: sender as! UICollectionViewCell) {
                controller.memeToEdit = delegate.memeArray?[indexPath.row]
            }
        }
    }
    
    

    

}

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
