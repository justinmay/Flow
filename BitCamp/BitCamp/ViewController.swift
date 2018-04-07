//
//  ViewController.swift
//  BitCamp
//
//  Created by Vineeth Puli on 4/6/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        
        locationManager.requestAlwaysAuthorization()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        StitchClientFactory
            .create(appId: "<your-client-app-id>")
            .done { (client: StitchClient) in
                // Perform requests to Stitch using the variable "client",
                // or assign the value of the variable "client" to some
                // property accessible outside this closure.
                
                // For example, if this is in a class which has a
                // stored StitchClient property named "stitchClient":
                self.stitchClient = client
            }.cauterize()
        */
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

