//
//  UserObject.swift
//  RandomUser
//
//  Created by osx on 14/07/16.
//  Copyright © 2016 lyzkov. All rights reserved.
//

import SwiftyJSON

class UserObject {
    var firstName: String!
    var gender: UserGender!
    var pictureURL: NSURL!
    
    required init(json: JSON) {
        firstName = json["name"]["first"].stringValue
        gender = UserGender(rawValue: json["gender"].stringValue)
        pictureURL = NSURL(string: json["picture"]["large"].stringValue)
    }
}
