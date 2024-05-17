//
//  Request.swift
//  downloadFiles
//
//  Created by Tejashree on 24/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit
import Foundation

class Request: NSObject {
    
    //get response in responseObject as JSON
    static func getResponseJSON(urlString:String,targetViewController: UIViewController?, completionHandler: @escaping (_ responseObject: NSDictionary?, _ error: NSError?) -> Void){
        

        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse is received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: []) as! NSDictionary
                completionHandler(jsonResponse, error as NSError?)

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    
    }
}
