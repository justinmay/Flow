//
//  NewCarViewController.swift
//  BitCamp
//
//  Created by Justin May on 4/7/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController, UITextFieldDelegate, BeaconScannerDelegate{
    
    @IBOutlet weak var parkedButton: UIButton!
    @IBAction func parkedButton(_ sender: UIButton) {
        self.parkedButton.backgroundColor = UIColor(red:0.94, green:0.28, blue:0.44, alpha:1.0)
        self.parkedButton.setTitle("Leave", for: .normal)
        self.beaconScanner.stopScanning()
    }
    @IBAction func newCarButton(_ sender: Any) {
        print("NEW CAR BUTTON TAPPED")
        self.parkedButton.backgroundColor = UIColor(red:0.02, green:0.84, blue:0.63, alpha:1.0)
        self.parkedButton.setTitle("Parked", for: .normal)
        newCarId = self.newCarTextField.text!
        print("NEW CAR ID : \(newCarId)")
        
        self.beaconScanner!.startScanning()
        
    }
    
    var newCarId : String!
    var array: [Double] = []
    var dick_tionary: [String:[Double]] = [:]
    var sumOfDicks: [String:Double] = [:]
    var distance: Double!
    var domainMax: Double!
    var domainMin: Double!
    var txPower = -58.0
    var sum = 0.0
    
    var beaconsSearched : [String] = []
    var parkingLotString : String!
    
    @IBOutlet weak var newCarTextField: UITextField!
    var beaconScanner: BeaconScanner!
    
    @IBOutlet weak var parkingLotLabel: UILabel!
    @IBOutlet weak var beaconNameLabel: UILabel!
    
    var beaconHardDict : [String : String] = [
        "http://www.shashank.com" : "Beacon0",
        "http://www.anandjustin.com" : "Beacon1",
        "http://www.vineeth.com" : "Beacon2",
        ]
    
    var parkingLotHardDict : [String : String] = [
        "10" : "E1",
        "9" : "F1",
        "8" : "E2",
        "7" : "F2",
        "6" : "C1",
        "5" : "D1",
        "4" : "C2",
        "3" : "D2",
        "2" : "A1",
        "1" : "B2"
    ]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden=false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.newCarTextField.delegate = self;
        self.navigationController?.navigationBar.isHidden=false;
        
        self.beaconScanner = BeaconScanner()
        self.beaconScanner!.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDistance(rssi: Int, txPower: Double) -> Double {
        if (rssi == 0) {
            return -1.0; // if we cannot determine accuracy, return -1.
        }
        
        let ratio = (Double(rssi))/txPower;
        if (ratio < 1.0) {
            return Double(pow(ratio,10));
        }
        else {
            let accuracy =  (0.89976)*pow(ratio,7.7095) + 0.111;
            return accuracy;
        }
    }
    
    func didFindBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
        NSLog("FIND: %@", beaconInfo.description)
    }
    func didLoseBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
        NSLog("LOST: %@", beaconInfo.description)
    }
    func didUpdateBeacon(beaconScanner: BeaconScanner, beaconInfo: BeaconInfo) {
        NSLog("UPDATE: %@", beaconInfo.description)
    }
    func didObserveURLBeacon(beaconScanner: BeaconScanner, URL: NSURL, RSSI: Int) {
        let distance = getDistance(rssi: RSSI, txPower: self.txPower)
        if(distance >= 3.0){
            return;
        }
        let beaconString = URL.absoluteString!
        if dick_tionary[beaconString] == nil {
            dick_tionary[beaconString] = [distance]
            sumOfDicks[beaconString] = 0.0
        } else {
            dick_tionary[beaconString]?.append(distance)
        }
        
        
        if distance < 0.05 {
            
            
            if (beaconsSearched.contains(beaconString)){
                //print("already there")
            } else {
                
                print(beaconString)
                let beaconActualString = beaconHardDict[beaconString]
                
                //dictionary for beacon
                
                self.beaconNameLabel.text = beaconActualString! + " passed"
                self.beaconsSearched.append(beaconString)
                //beaconScanner.stopScanning()
                
                if(beaconString == "http://www.shashank.com"){
                    
                    Networking.requestParkingSpot(carID: newCarId, beaconID: beaconString, completionHandler: { response, error in
                        
                        print("reached")
                        if (error != nil){
                            print(error ?? "error")
                            //wont happen
                            //dictionary
                            
                        } else {
                            print("GO TO PARKING LOT \(response!)")
                            //switch case here
                            self.parkingLotString = response!
                            self.parkingLotLabel.text = response!
                            
                        }
                    })
                } else if (beaconString == "http://www.anandjustin.com"){
                    //PASSES SECOND BEACON (BEACON 1), SENDS POST TO SERVER AND CHANGES BIG SCREEN
                    if parkingLotString != nil {
                        
                        Networking.passSecondBeacon(parkingSpot: self.parkingLotString, completionHandler: { error in
                            if (error != nil){
                                print(error ?? "error")
                            } else {
                                print("Successfully sent")
                            }
                        })
                    }
                }
            }
        }
        print("real distance is \(distance)")
        if(dick_tionary[beaconString]!.count >= 5){
            sumOfDicks[beaconString]! -=  dick_tionary[beaconString]![dick_tionary[beaconString]!.count - 5]
        }
        dick_tionary[beaconString]!.append(distance)
        sumOfDicks[beaconString]! += distance
        print(sumOfDicks[beaconString]!)

        if(dick_tionary[beaconString]!.count>=6){
            print("URL SEEN: \(URL), RSSI: \(RSSI), Distance: \(sumOfDicks[beaconString]! / 5)")
        }
        //print(array[..<5])
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

