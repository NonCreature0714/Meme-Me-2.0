//
//  MemeTableViewController.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/18/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    //MARK: members
    var memes: [Meme]!
    
    //MARK: overriden UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.tabBar.isHidden = false;
        print("In MemeTableViewController, viewDidLoad() called.")
        reloadInputViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        tableView?.reloadData()
        print("In MemeTableViewController, viewWillAppear() called; number of memes: ", memes.count)
        
    }

    //MARK: Overriden TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows in table view: ", memes.count)
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = meme.topTextField
        //let imageView = UIImageView(image: meme.memedImage)
        cell.imageView?.image = meme.memedImage
        //cell.imageView?.image = UIImage(cgImage: meme.memedImage as! CGImage)
        print("In MemeMeTableViewController, tableView(cellForRowAt) called.")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    
    
    
}
