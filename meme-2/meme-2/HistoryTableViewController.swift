//
//  TableViewController.swift
//  meme-1
//
//  Created by Wael Yazqi on 2019-04-28.
//  Copyright © 2019 Wael. All rights reserved.
//
import Foundation
import UIKit

class HistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
// Outlet for table view
    

// View will appear
    override func viewWillAppear(_ animated: Bool) {
        //reload the data in case there is new memes
       // self.tableView.reloadData()
    }
    
// Using shared array Model
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
   @IBOutlet weak var memeTableView: UITableView!

    
// 2 Table Protocol for UI Table View Data Source
    //1-  identify number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    // 2- insert Particuler Cell in the table
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tablecell")! as! Tablecell
        let meme = memes[indexPath.row]
        
        // Set the name and image
         cell.imagetablecell.image = meme.memedImage
         cell.Labeltablecell.text = meme.topTextField + " " + meme.bottomTextField
         return cell
        
    }
    
// Tells the delegate that the specified row is now selected.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
{
    
    //  To load a view controller from a storyboard, call the instantiateViewController(withIdentifier:) method of the appropriate UIStoryboard object. The storyboard object creates the view controller and returns it to your code. Instantiates and returns the view controller with the specified identifier.
    
let detailController = self.storyboard!.instantiateViewController(withIdentifier: "Detailview") as! MemeDetailViewController
    detailController.meme = self.memes[(indexPath.row)]
self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    }

