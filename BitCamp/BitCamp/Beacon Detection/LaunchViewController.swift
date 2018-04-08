//
//  LaunchViewController.swift
//  BitCamp
//
//  Created by Justin May on 4/8/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var circle: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 10.0, animations: {
            self.circle.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
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
