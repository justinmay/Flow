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
        self.parkedButton.backgroundColor = UIColor(red:0.02, green:0.84, blue:0.63, alpha:1.0)
        self.parkedButton.setTitle("Parked", for: .normal)
        self.beaconScanner!.startScanning()

    }
    var array: [Double] = []
    var dick_tionary: [String:[Double]] = [:]
    var sumOfDicks: [String:Double] = [:]
    var distance: Double!
    var domainMax: Double!
    var domainMin: Double!
    var txPower = -58.0
    var sum = 0.0
    
    var beaconsSearched : [String] = []
    
    @IBOutlet weak var newCarTextField: UITextField!
    var beaconScanner: BeaconScanner!

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
                print("already there")
            } else {
                Networking.requestParkingSpot(carID: "7", beaconID: beaconString, completionHandler: {error in
                    print("hi")
                })
                beaconsSearched.append(beaconString)
            }
            
        }
        print("real distance is \(distance)")
        if(dick_tionary[beaconString]!.count >= 5){
            sumOfDicks[beaconString]! -=  dick_tionary[beaconString]![dick_tionary[beaconString]!.count - 5]
        }
        dick_tionary[beaconString]!.append(distance)
        sumOfDicks[beaconString]! += distance
        if(dick_tionary[beaconString]!.count>=6){
             print("URL SEEN: \(URL), RSSI: \(RSSI), Distance: \(sum / 5)")
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
