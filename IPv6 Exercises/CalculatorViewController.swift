//
//  CalculatorViewController.swift
//  170304 IP Calculator
//
//  Created by Anders Pedersen on 05/03/17.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var routingPrefixLbl: UILabel!
    @IBOutlet weak var subnetIdLbl: UILabel!
    @IBOutlet weak var numberOf64Lbl: UILabel!
    @IBOutlet weak var prefixLbl: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    var networkv6Address = Networkv6Address()    
    var sliderValue = 48
    let prefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontSize()
        sliderValue = prefs.integer(forKey: "sliderValue")
        if sliderValue == 0 { sliderValue = 48 }
        sliderOutlet.value = Float(sliderValue)
        drawView()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        drawView()
    }
    
    func setFontSize() {
        let myFontSize = fontsize()
        routingPrefixLbl.font = UIFont.systemFont(ofSize: myFontSize)
        subnetIdLbl.font = UIFont.systemFont(ofSize: myFontSize)
        numberOf64Lbl.font = UIFont.systemFont(ofSize: myFontSize)
        prefixLbl.font = UIFont.systemFont(ofSize: myFontSize)
    }
    
    func drawView() {
        routingPrefixLbl.text = "Routing prefix: \(sliderValue) bits"
        subnetIdLbl.text = "Subnet id: \(64 - sliderValue) bits"

        let numberOf64 = pow(2, Double(64 - sliderValue))
        numberOf64Lbl.text = "# of /64's: \(Int(numberOf64))"
        
        networkv6Address.genFromPrefixLength(sliderValue)
        prefixLbl.text = "Prefix: " + networkv6Address.string()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let prefs = UserDefaults.standard
        prefs.setValue(sliderValue, forKey: "sliderValue")
    }

}
