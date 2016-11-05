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
        
        let space: CGFloat = 3.0
        let w = (self.view.frame.size.width - (2 * space)) / 3.0
        let h = (self.view.frame.size.height - (2 * space)) /  5.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: w, height: h)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        reloadInputViews()
        flowLayout.collectionView?.reloadData()
    }
    
    
    //MARK: Overriden CollectionView Datasource methods.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
