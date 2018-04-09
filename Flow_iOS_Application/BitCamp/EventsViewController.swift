//
//  EventsViewController.swift
//  BitCamp
//
//  Created by Justin May on 4/7/18.
//  Copyright © 2018 Vineeth. All rights reserved.
//

import UIKit
import Foundation

class EventsViewController: UIViewController {

    @IBOutlet weak var pg: UILabel!
    @IBOutlet weak var labels: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var wingspan: UILabel!
    @IBOutlet weak var threept: UILabel!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    @objc func superDukeSwipe(_ sender: UISwipeGestureRecognizer) {
        print("hi");
        if sender.direction == UISwipeGestureRecognizerDirection.left{
            self.performSegue(withIdentifier: "Duke2UMD", sender: self)
            
        }
    }
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden=false;
        
        self.labels.alpha=0;
        self.height.alpha=0;
        self.name.alpha=0;
        self.wingspan.alpha=0;
        self.pg.alpha=0;
        self.threept.alpha=0;
        self.pts.alpha=0;
        self.weight.alpha=0;
        self.labels.fadeIn()
        self.name.fadeIn()
        self.height.fadeIn()
        self.wingspan.fadeIn()
        self.pg.fadeIn()
        self.threept.fadeIn()
        self.pts.fadeIn()
        self.weight.fadeIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var superSuperDupeSwipeLeft = UISwipeGestureRecognizer(target: self,action: #selector(EventsViewController.superDukeSwipe(_:)))
        superSuperDupeSwipeLeft.direction = .left
        self.view.addGestureRecognizer(superSuperDupeSwipeLeft)
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

extension UIView {
    func fadeIn(duration: TimeInterval = 2.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveLinear, animations: {
            self.frame.origin = CGPoint(x: self.frame.origin.x + 20, y: self.frame.origin.y)  // Ending position of the Label
            //self.frame.origin.x = self.frame.origin.x + 20
        }, completion: nil)
    }
    
}
