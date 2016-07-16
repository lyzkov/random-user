//
//  ViewController.swift
//  RandomUser
//
//  Created by osx on 13/07/16.
//  Copyright © 2016 lyzkov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Haneke

class ViewController: UIViewController {

    var user: UserObject?
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var gender: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetViews()
        getDummyData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getDummyData() {
        RestApiManager.sharedInstance.getRandomUser { (json: SwiftyJSON.JSON) in
            if let userEntry = json["results"].array?.first {
                self.user = UserObject(json: userEntry)
            } else {
                self.user = nil
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        if let user = self.user {
            usernameLabel.text = user.firstName
            picture.hnk_setImageFromURL(user.pictureURL)
            switch user.gender! {
            case .Male:
                gender.image = UIImage(named: "Male")
            case .Female:
                gender.image = UIImage(named: "Female")
            }
        } else {
            resetViews()
        }
    }
    
    func resetViews() {
        usernameLabel.text = ""
        gender.image = nil
        picture.image = nil
    }
}

