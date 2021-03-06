//
//  PostTableViewController.swift
//  FoodHunter
//
//  Created by Joe Durand on 11/12/16.
//  Copyright © 2016 Cal Poly App Dev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PostTableViewController: UITableViewController{
    
    @IBOutlet var addBarButton: UIBarButtonItem!
    
    var currentPosts: [Post] = []
    
    override func viewDidLoad() {
        
        print("view did load!")
        
        let postOne = Post()
        let postTwo = Post()
        postTwo.food = "Spaghetti"
        
        currentPosts = [postOne, postTwo]
        
        setupDBLink()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")
    }
    
    func setupDBLink() {
        let ref = FIRDatabase.database().reference()
        let posts = ref.child("posts")
        posts.observe(FIRDataEventType.value, with: {datasnapshot in
            
            print(datasnapshot.value.debugDescription)
        })
    }
    
    @IBAction func navBarButtonPressed(_ sender: UIBarButtonItem) {
        
        if sender == addBarButton {
            self.performSegue(withIdentifier: "addButtonSegue", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPosts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt", indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.setup(record: currentPosts[indexPath.row])
            return cell
        }
        else {
            print("DEBUG: unable to create PostCell!")
            return UITableViewCell()
        }
    }
}
