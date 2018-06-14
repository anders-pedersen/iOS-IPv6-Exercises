//
//  miscClasses.swift
//  170304 IP Calculator
//
//  Created by Anders Pedersen on 06/03/17.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit


func fontsize() -> CGFloat {
    let maxLength = max(UIScreen.main.bounds.size.width , UIScreen.main.bounds.size.height)
    // case 568: iPhone SE
    // case 667: iPhone 6/6s
    if maxLength < 667 {
        return 18
    } else {
        return 24
    }
}

func fontsizesmall() -> CGFloat {
    let maxLength = max(UIScreen.main.bounds.size.width , UIScreen.main.bounds.size.height)
    // case 568: iPhone SE
    // case 667: iPhone 6/6s
    if maxLength < 667 {
        return 15
    } else {
        return 21
    }
}

func genList(_ intValue: Int) -> [Int] { // generate scrambled list of n elements
    if intValue > 10 { return [] }
    let scope = [0,1,2,3,4,5,6,7,8,9,10]
    var nums = scope[0...intValue]
    var result: [Int] = []
    while nums.count > 0 {
        let arrayKey = GKRandomSource.sharedRandom().nextInt(upperBound: nums.count)
        result.append(nums[arrayKey])
        nums.remove(at: arrayKey)
    }
    return result
}







