//
//  Networking.swift
//  BitCamp
//
//  Created by Justin May on 4/7/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    var url: String? {
        return "http://eab6a836.ngrok.io"
    }
    
    class func requestParkingSpot(carID: String, beaconID: String, completionHandler: @escaping (NSError?) -> ()){
        
        let parameters : Parameters = [
            "carId" : carID,
            "beaconId" : beaconID
        ]
        
        Alamofire.request(Networking().url! + "/request", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString {
            (response) in
            
            print(response)
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(nil)
            case .failure(let error):
                completionHandler(error as NSError)
            }
        }
        
    }
}
