//
//  Event2ViewController.swift
//  BitCamp
//
//  Created by Justin May on 4/7/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit

class Event2ViewController: UIViewController {
    @IBOutlet weak var threept: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var wingspan: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var pointGuard: UILabel!
    @IBOutlet weak var labels: UILabel!
    @IBOutlet weak var pts: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.labels.alpha=0;
        self.height.alpha=0;
        self.name.alpha=0;
        self.wingspan.alpha=0;
        self.pointGuard.alpha=0;
        self.threept.alpha=0;
        self.pts.alpha=0;
        self.weight.alpha=0;
        self.labels.fadeIn()
        self.name.fadeIn()
        self.height.fadeIn()
        self.wingspan.fadeIn()
        self.pointGuard.fadeIn()
        self.pointGuard.fadeIn()
        self.threept.fadeIn()
        self.pts.fadeIn()
        self.weight.fadeIn()
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


