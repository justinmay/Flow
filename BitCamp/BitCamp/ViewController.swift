//
//  ViewController.swift
//  BitCamp
//
//  Created by Vineeth Puli on 4/6/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {

    var userInputName: String!
    var passwordInput: String!
    
    var user = "chips"
    var pass = "guac"
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginToNewCarSegue(_ sender: Any) {
        userInputName = usernameTextField.text!
        passwordInput = passwordTextField.text!
        
        if userInputName == user && passwordInput == pass {
            self.performSegue(withIdentifier: "mainMenuSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "welcomeSegue", sender: self)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          self.navigationController?.navigationBar.isHidden=true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.hideKeyboardWhenTappedAround()
      
        //let locationManager = CLLocationManager()
      
      //  locationManager.requestAlwaysAuthorization()
        
        self.usernameTextField.delegate = self;
        self.passwordTextField.delegate = self;
        
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

