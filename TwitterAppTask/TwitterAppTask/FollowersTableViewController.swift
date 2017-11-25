//
//  FollowersTableViewController.swift
//  TwitterAppTask
//
//  Created by MohamedSh on 11/24/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit

class FollowersTableViewController: UITableViewController {
    var followersList:[(name:String,handler:String,bio:String?,profilImageURL:URL?,bakgrounImageURL:URL?)]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return followersList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowersCell", for: indexPath) as! FollowersTableViewCell
        cell.followerName.text=followersList[indexPath.row].name
        cell.followerHandler.text=followersList[indexPath.row].handler
       
        if let bioHasValue=followersList[indexPath.row].bio{
            cell.followerBio.text=bioHasValue
        }
        if let thereIsProfileImage = followersList[indexPath.row].profilImageURL {
          DispatchQueue.global(qos: .userInitiated).async {
                let pData=NSData(contentsOf: thereIsProfileImage)
                let userImg=UIImage(data: pData! as Data)
                DispatchQueue.main.async {
                    cell.followerImage.image=userImg
                }
            }
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFollowerInforamtion"{
            let didSelectedFolloweToShowDetails = tableView.indexPathForSelectedRow?[1]
            if let dest = segue.destination as? DisplayFollowerInofTableViewController {
                dest.backgroundImageURL = followersList[didSelectedFolloweToShowDetails!].bakgrounImageURL
                dest.profilImageURL = followersList[didSelectedFolloweToShowDetails!].profilImageURL
            }
            
            
        }
    }
}
