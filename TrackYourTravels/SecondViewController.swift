//
//  SecondViewController.swift
//  TrackYourTravels
//
//  Created by Jidde Koekoek on 30/05/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//

import UIKit
import MapKit
import CoreGraphics

class SecondViewController: UIViewController {
    
    @IBOutlet var periodSetter: UISegmentedControl!
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let locations = DatabaseManager.sharedInstance.readAllFromDatabase()
        
        for l in locations {
            label.text = l.timestamp
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

