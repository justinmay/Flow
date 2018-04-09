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
        return "http://2f487a92.ngrok.io"
        
    }
    
    class func requestParkingSpot(carID: String, beaconID: String, completionHandler: @escaping (String?, NSError?) -> ()){
        
        let parameters : Parameters = [
            "carId" : carID,
            "beaconId" : beaconID
        ]
        
        Alamofire.request(Networking().url! + "/request", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString {
            (response) in
            
            print(response)
            switch response.result {
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
        }
        
    }
    
    class func passSecondBeacon(parkingSpot: String, completionHandler: @escaping (NSError?) -> ()){
        
        let parameters : Parameters = [
            //"carId" : carID,
            "parkingSpot" : parkingSpot
        ]
        
        Alamofire.request(Networking().url! + "/beaconPast", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString {
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
    
    class func passThirdBeacon(parkingSpot: String, completionHandler: @escaping (NSError?) -> ()){
        
        let parameters : Parameters = [
            //"carId" : carID,
            "parkingSpot" : parkingSpot
        ]
        
        Alamofire.request(Networking().url! + "/beaconFuture", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString {
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
    
    class func leave(carId: String, completionHandler: @escaping (NSError?) -> ()){
        
        let parameters : Parameters = [
            //"carId" : carID,
            "carId" : carId
        ]
        
        Alamofire.request(Networking().url! + "/leave", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString {
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
