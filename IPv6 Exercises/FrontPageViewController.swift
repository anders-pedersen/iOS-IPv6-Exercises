//
//  FrontPageViewController.swift
//  170304 IP Calculator
//
//  Created by Anders Pedersen on 04/03/17.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import UIKit

class FrontPageViewController: UIViewController {
    
    @IBOutlet weak var eui64Label: UIButton!
    @IBOutlet weak var linkLocalLabel: UIButton!
    @IBOutlet weak var routeEntryLabel: UIButton!
    @IBOutlet weak var sNMcastEntryLabel: UIButton!
    
    @IBOutlet weak var calcLabel: UIButton!    
    @IBOutlet weak var aboutLabel: UIButton!
    
    var initialRun = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setFontSize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    @IBAction func unwindToFrontPage(segue: UIStoryboardSegue) {}

    func setFontSize() {
        let myFontSize = fontsize()
        
        
        eui64Label.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        linkLocalLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        routeEntryLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        sNMcastEntryLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)

        calcLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        aboutLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: myFontSize, weight: UIFontWeightBold), NSForegroundColorAttributeName: UIColor.black]
    }
    
}



