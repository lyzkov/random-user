//
//  RestApiManager.swift
//  RandomUser
//
//  Created by osx on 14/07/16.
//  Copyright © 2016 lyzkov. All rights reserved.
//

import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://api.randomuser.me/"
    
    func getRandomUser(onCompletion: (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(route) { json, err in
            onCompletion(json as JSON)
        }
    }
    
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {data, response, error -> Void in
            if let jsonData = data {
                let json = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error)
            }
        }
        task.resume()
    }
}
