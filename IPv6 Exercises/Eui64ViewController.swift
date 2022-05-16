//
//  Eui64ViewController.swift
//  IPv6 Exercises
//
//  Created by Anders Pedersen on 27/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import UIKit

class Eui64ViewController: UIViewController {
    
    @IBOutlet weak var macAddressLabel: UILabel!
    @IBOutlet weak var gamesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var resetLabel: UIButton!
    @IBOutlet var buttonArray: Array<UIButton>!
    
    let mac = MacAddress()
    let eui64Tuple = Eui64Tuple()
    
    var games = 0
    var score = 0
    var isIfIdPressed = false
    let prefs = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        setFontSize()
        games = prefs.integer(forKey: "mGames")
        score = prefs.integer(forKey: "mScore")
        gamesPrint()
        mGenSet()
    }
    
    // UI interaction
    
    @IBAction func ifIdPressed(_ sender: AnyObject) {
        if (!isIfIdPressed) {
            let funcValue = sender.tag            
            
            if funcValue! == eui64Tuple.right {
                score += 1
                setButtonColor(buttonNumber: funcValue!, correct: 1)
            } else {
                setButtonColor(buttonNumber: funcValue!, correct: 0)
                setButtonColor(buttonNumber: eui64Tuple.right, correct: 1)
            }
            games += 1
            if games == 10 {
                triggerAlert(gms: games, scr: score)
            }
            isIfIdPressed = true
            nextLabel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        }
    }

    
    @IBAction func nextPressed(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        games = 0
        score = 0
        gamesPrint()
        mGenSet()
    }
    
    // Game mechanics
    
    func mGenSet() {
        nextLabel.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
        isIfIdPressed = false
        for i in 0 ... 3 { setButtonColor(buttonNumber: i, correct: 2) }
        eui64Tuple.generate()
        macAddressLabel.text = "MAC Address: \(eui64Tuple.mac.string())"
        for i in 0 ... 3 {
            buttonArray[i].setTitle(eui64Tuple.eui64[i].ifIdString(), for: UIControl.State.normal)
        }
        
        // debug
        print("Answer: \(eui64Tuple.right)")
        // debug end
        
    }
    
    func nextQuestion() {
        if isIfIdPressed {
            animateTransition()
            gamesPrint()
            mGenSet()
        }
    }
    
    // UI update
    
    func gamesPrint() {
        if games > 9 {
            games = 0
            score = 0
        }
        var percent:Float = 0
        if games == 0 { percent = 0 } else { percent = (Float(score) / Float(games) * 100) }
        gamesLabel.text = "Rounds played: \(games)"
        scoreLabel.text = "Score:  " + String.localizedStringWithFormat("%.0f", percent) + "%"
    }
    
    func animateTransition() {
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            () -> Void in
            for i in 0 ... 3 { self.buttonArray[i].isHidden = true }
            self.view.backgroundColor = UIColor.lightGray
        }, completion: { (finished: Bool) -> Void in
            self.view.backgroundColor = UIColor.groupTableViewBackground
            for i in 0 ... 3 { self.buttonArray[i].isHidden = false }
            self.gamesLabel.isHidden = false
            self.scoreLabel.isHidden = false
        })
    }

    func setButtonColor(buttonNumber: Int, correct: Int) {
        let greenColor = UIColor(red: CGFloat(128)/255, green: CGFloat(255)/255, blue: CGFloat(0)/255, alpha: 1.0)
        let redColor = UIColor(red: CGFloat(255)/255, green: CGFloat(102)/255, blue: CGFloat(102)/255, alpha: 1.0)
        let button = buttonArray[buttonNumber]
        if correct == 1 {
            button.backgroundColor = greenColor
        } else  if correct == 0 {
            button.backgroundColor = redColor
        } else {
            button.backgroundColor = UIColor.groupTableViewBackground
        }
    }
    
    func setFontSize() {
        macAddressLabel.font = UIFont.systemFont(ofSize: fontsizesmall())
        let myFontSize = fontsize()
        for i in 0 ... 3 {
            buttonArray[i].titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        }
        gamesLabel.font = UIFont.systemFont(ofSize: myFontSize)
        scoreLabel.font = UIFont.systemFont(ofSize: myFontSize)
        nextLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
        resetLabel.titleLabel?.font = UIFont.systemFont(ofSize: myFontSize)
    }
    
    func triggerAlert(gms: Int, scr: Int) {
        self.gamesLabel.isHidden = true
        self.scoreLabel.isHidden = true
        var percent:Float = 0
        percent = (Float(scr) / Float(gms) * 100)
        let completeString = "\(scr)/\(gms) = \(percent)%"
        let completeAlert = UIAlertController(title: "Complete", message: completeString, preferredStyle: .alert)
        completeAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(completeAlert, animated: true, completion: nil)
    }
    
    // Store current values on exit
    
    override func viewDidDisappear(_ animated: Bool) {
        let prefs = UserDefaults.standard
        prefs.setValue(games, forKey: "mGames")
        prefs.setValue(score, forKey: "mScore")
    }

}
