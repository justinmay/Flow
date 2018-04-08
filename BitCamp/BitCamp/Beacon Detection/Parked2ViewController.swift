//
//  Parked2ViewController.swift
//  BitCamp
//
//  Created by Justin May on 4/8/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit

class Parked2ViewController: UIViewController {

    @IBOutlet weak var parkedText: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.parkedText.alpha = 0;
        self.parkedText.faded(completion: {(finished:Bool) -> Void in self.parkedText.fadeOut()})
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.performSegue(withIdentifier: "parked2segue", sender: self)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
