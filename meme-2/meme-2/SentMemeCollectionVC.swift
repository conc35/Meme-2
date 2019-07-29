//
//  CollectionViewController.swift
//  meme-1
//
//  Created by Wael Yazqi on 2019-04-28.
//  Copyright © 2019 Wael. All rights reserved.
//

import UIKit
import Foundation

class SentMemeCollectionVC: UICollectionViewController {

// identification
    
    @IBOutlet weak var FlowLayOut: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
// View Did Load function
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        _ = (view.frame.size.height - (2 * space)) / 3.0
        FlowLayOut.minimumInteritemSpacing = space
        FlowLayOut.minimumLineSpacing = space
        FlowLayOut.itemSize = CGSize(width: dimension, height: dimension)
    }

// View will appear
    override func viewWillAppear(_ animated: Bool) {
        //reload the data in case there is new memes
        self.collectionView!.reloadData()
    }

    
    //1-  identify number of rows in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // 2- insert Particuler Cell in the table
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        // Set the name and image
        cell.collectionImage.image = meme.memedImage

        return cell
    }
// Tells the delegate that the specified row is now selected.
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "Detailview") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath.row)]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    

}
