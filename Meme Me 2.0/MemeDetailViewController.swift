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
    
    
    @IBOutlet weak var memeImage: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImage?.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
        print("In MemeDetailViewController, viewDidLoad() called.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("In MemeDetailViewController, viewWillAppear() called.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        print("In MemeDetailViewController, viewWillDisappear() called.")
    }
    
}
