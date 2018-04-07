//
//  NewCarViewController.swift
//  BitCamp
//
//  Created by Justin May on 4/7/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController, UITextFieldDelegate, BeaconScannerDelegate{

    var array: [Double] = []
    var distance: Double!
    var domainMax: Double!
    var domainMin: Double!
    var txPower = -58.0
    var sum = 0.0
    
    @IBOutlet weak var newCarTextField: UITextField!
    var beaconScanner: BeaconScanner!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.newCarTextField.delegate = self;
        self.navigationController?.navigationBar.isHidden=false;
        
        self.beaconScanner = BeaconScanner()
        self.beaconScanner!.delegate = self
        self.beaconScanner!.startScanning()

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
        
        var ratio = (Double(rssi))/txPower;
        if (ratio < 1.0) {
            return Double(pow(ratio,10));
        }
        else {
            var accuracy =  (0.89976)*pow(ratio,7.7095) + 0.111;
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
        print("real distance is \(distance)")
        if(distance >= 3.0){
            return;
        }
        if(array.count >= 5){
            sum -=  array[array.count - 5]
        }
        array.append(distance)
        sum += distance
        if(array.count>=6){
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
