//
//  MemeCollectionViewController.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/18/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    
    //MARK: IBOutlet(s)
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Members
    var memes: [Meme]!
    
    
    //MARK: Overriden UIViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.tabBar.isHidden = false;
        
        print("In MemeCollectionViewController, viewDidLoad() called.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        reloadInputViews()
        print("In MemeCollectionViewController, viewWillAppear() called; number of memes: ", memes.count)
        flowLayout.collectionView?.reloadData()
    }
    
    
    //MARK: Overriden CollectionView Datasource methods.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in colleciton view: " , memes.count)
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView.image = meme.memedImage
        print("In MemeMeCollectionViewController, collectionView(cellForItemAt) called.")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
