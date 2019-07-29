//
//  MemeDetailViewController.swift
//  meme-1
//
//  Created by Wael Yazqi on 2019-04-30.
//  Copyright © 2019 Wael. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme : Meme!
    
    @IBOutlet weak var memeimage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memeimage.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    }
