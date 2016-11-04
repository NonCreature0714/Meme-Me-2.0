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
        reloadInputViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        tableView?.reloadData()
    }

    //MARK: Overriden TableView Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = meme.topTextField
        cell.imageView?.image = meme.memedImage
        if let bottomText = meme.bottomTextField {
            cell.detailTextLabel?.text = bottomText
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let meme = memes[(indexPath as NSIndexPath).row]
        detailController.meme = meme
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    
    
    
}
