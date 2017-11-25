//
//  DisplayFollowerInofTableViewController.swift
//  TwitterAppTask
//
//  Created by MohamedSh on 11/24/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//

import UIKit

class DisplayFollowerInofTableViewController: UITableViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profilImage: UIImageView!
    var backgroundImageURL:URL?
    var profilImageURL:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    func updateUI(){
        DispatchQueue.global(qos: .userInitiated).async {
            if self.backgroundImageURL != nil{
                let urlData=NSData(contentsOf: self.backgroundImageURL!)
                let backImg=UIImage(data: urlData! as Data)
                DispatchQueue.main.async {
                    self.backgroundImage.image=backImg
                }
            }
            if self.profilImageURL != nil {
                let urlDataProfil=NSData(contentsOf: self.profilImageURL!)
                let profileImg=UIImage(data: urlDataProfil! as Data)
                DispatchQueue.main.async {
                    self.profilImage.image=profileImg
                }
            }
        }
    }

}
