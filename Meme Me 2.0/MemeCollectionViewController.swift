//
//  MemeCollectionViewController.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/18/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.tabBar.isHidden = false;
        
        print("In MemeCollectionViewController, viewDidLoad() called.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        print("In MemeCollectionViewController, viewWillAppear() called; number of memes: ", memes.count)
    }
    
    
    //MARK: CollectionView Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in colleciton view: " , memes.count)
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        let imageView = UIImageView(image: meme.memedImage)
        cell.memeImageView = imageView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
