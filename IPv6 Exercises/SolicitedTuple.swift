//
//  SolicitedTuple.swift
//  IPv6 Exercises
//
//  Created by Anders Pedersen on 30/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation
import GameplayKit

class SolicitedTuple {
    
    var address = [Ipv6Address]()
    var ipv6Address = Ipv6Address()
    var right: Int = 0
    
    init() {
        for _ in 0 ... 3 {
            address.append(NetPrefix())
        }
    }
    
    func generate() {
        let correctSNAddress = Ipv6Address()
        
        // generate ipv6 address and adjust to be suited for solicited-node multicast address
        ipv6Address.genRandom()
        // 6=7 7=3 3=0
        ipv6Address.group[6] = ipv6Address.group[7]
        ipv6Address.group[7] = ipv6Address.group[3]
        ipv6Address.group[3] = 0
        
        // generate correct solicited-node multicast address and store
        correctSNAddress.group = [0,0,0,0, 0,0,0,0]
        correctSNAddress.group[0] = hexToInt("ff02")
        correctSNAddress.group[5] = 1
        correctSNAddress.group[6] = (255 * 256) + (ipv6Address.group[6] % 256)
        correctSNAddress.group[7] = ipv6Address.group[7]
        
        // reset address group values
        for i in 0...3 {
            address[i].group = correctSNAddress.group
        }
        
        // generate incorrect values
        let longList = genList(6)
        print("longList: \(longList)")
        for i in 0 ... 3 {
            sn_toggle(longList[i], &address[i])
        }
        
        // generate correct value and re-align
        right = GKRandomSource.sharedRandom().nextInt(upperBound: 4)
        address[right].group = correctSNAddress.group
        
    }
}

func sn_toggle(_ toggle: Int, _ addressValue: inout Ipv6Address) -> Void {
    switch toggle {
    case 0:
        sn_quiz0(&addressValue)
    case 1:
        sn_quiz1(&addressValue)
    case 2:
        sn_quiz2(&addressValue)
    case 3:
        sn_quiz3(&addressValue)
    case 4:
        sn_quiz4(&addressValue)
    case 5:
        sn_quiz5(&addressValue)
    case 6:
        sn_quiz6(&addressValue)
    default:
        sn_quiz0(&addressValue)
    }
}

func sn_quiz0(_ addressValue: inout Ipv6Address) -> Void {
    // g6=fexx
    let intValue = addressValue.group[6]
    addressValue.group[6] = (hexToInt("fe") * 256 ) + (intValue % 256)
}

func sn_quiz1(_ addressValue: inout Ipv6Address) -> Void {
    // g6=fffx
    let intValue = addressValue.group[6]
    let newValue = (hexToInt("fff") * 16 ) + (intValue % 16)
    if newValue != addressValue.group[6] {
        addressValue.group[6] = (hexToInt("fff") * 16 ) + (intValue % 16)
        print("quiz1 match")
    } else {
        addressValue.group[6] = (hexToInt("ff0") * 16 ) + (intValue % 16)
    }
    
}

func sn_quiz2(_ addressValue: inout Ipv6Address) -> Void {
    // g5=0
    addressValue.group[5] = 0
}

func sn_quiz3(_ addressValue: inout Ipv6Address) -> Void {
    // g6 = 0fxx
    let intValue = addressValue.group[6]
    addressValue.group[6] = (hexToInt("f") * 256 ) + (intValue % 256)
}

func sn_quiz4(_ addressValue: inout Ipv6Address) -> Void {
    // g1=1 & g5=0
    addressValue.group[1] = 1
    addressValue.group[5] = 0
}

func sn_quiz5(_ addressValue: inout Ipv6Address) -> Void {
    // g0=ff20
    addressValue.group[0] = hexToInt("ff20")
}

func sn_quiz6(_ addressValue: inout Ipv6Address) -> Void {
    // g0=ff & g1=2
    addressValue.group[0] = 255
    addressValue.group[1] = 2
}


// g7=highest bit set <--- Not used

