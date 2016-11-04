//
//  MemeDetailViewController.swift
//  Meme Me 2.0
//
//  Created by William Brubaker on 10/29/16.
//  Copyright © 2016 William Brubaker. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    //MARK: IBOutlet(s)
    @IBOutlet weak var memeImage: UIImageView!
    
    //MARK: Member(s)
    var meme: Meme!
    
    //MARK: Overriden UIViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage?.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
