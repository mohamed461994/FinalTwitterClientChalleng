//
//  ViewController.swift
//  TwitterAppTask
//
//  Created by MohamedSh on 11/23/17.
//  Copyright © 2017 MohamedSh. All rights reserved.
//
import UIKit
import TwitterKit
class ViewController: UIViewController {
    var followersList:[(name:String,handler:String,bio:String?,profilImageURL:URL?,bakgrounImageURL:URL?)]=[]
    var readyTosegue:Bool?{
        didSet{
//            if !(followersList.isEmpty){
//                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "followersId") as! FollowersTableViewController
//                secondViewController.followersList = self.followersList
//                self.navigationController?.pushViewController(secondViewController, animated: true)
//                 performSegue(withIdentifier: "ShowFollowers", sender: self )
//            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                // if sucsses in sign in
                self.excuteJson(id: session!.userID)
                
            } else {
                print("error: \(error!.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        DispatchQueue.main.async {
            self.view.addSubview(logInButton)
        }
        
    }
    func excuteJson(id:String){
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/followers/list.json"
        let params = ["id": id]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError!)")
            }
            do {
                //parssing twitter JSON
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let users=json["users"] as! [[String:Any]]
                var nestedBio:String?
                var nestedBackgroundImageURL:URL?
                var nestedProfileImageURL:URL?
                for follower in users{
                    //if there is no feature in twitter it's value will be nil
                    nestedBio = nil
                    nestedBackgroundImageURL=nil
                    nestedProfileImageURL=nil
                    if let thereIsBackGroung = follower["profile_background_image_url_https"] as? String {
                        
                         nestedBackgroundImageURL = URL(string: thereIsBackGroung)
                        
                    }
                    if let thereIsDescriptio = follower["description"] as? String{
                        nestedBio=thereIsDescriptio
                    }
                    if let thereIsProfileImage = follower["profile_image_url_https"] as? String {
                        nestedProfileImageURL = URL(string:thereIsProfileImage )
                    }
                    
                    self.followersList.append((name: follower["name"] as! String,
                                           handler: follower["screen_name"] as! String,
                                           bio: nestedBio ,
                                           profilImageURL: nestedProfileImageURL,
                                           bakgrounImageURL: nestedBackgroundImageURL))
                }
                self.readyTosegue=true//to segue after ending
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let disVC=segue.destination
        if segue.identifier == "ShowFollowers" {
            //print("idintifier Founded")
            if let vc = disVC as? FollowersTableViewController {
                //print("to foollowes view controler founded ")
                vc.followersList = self.followersList
            }
        }
    }
}
