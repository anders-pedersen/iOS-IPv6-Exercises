//
//  LinkLocalTuple.swift
//  IPv6 Exercises
//
//  Created by Anders Pedersen on 28/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation
import GameplayKit

class LinkLocalTuple {
    
    var ll = [Ipv6Address]()
    var right: Int
    
    init() {
        right = 0
        for _ in 0 ... 3 {
            ll.append(Ipv6Address())
        }
    }
    
    func generate() {
        let correctSNAddress = Ipv6Address()
        let mac = MacAddress()
        
        // generate correct address with MAC addresses as interface identifier
        correctSNAddress.group = [hexToInt("fe80"),0,0,0, 0,0,0,0]
        for i in 0...3 {
            ll[i].group = correctSNAddress.group
            mac.genRandom()
            insertMac(mac, &ll[i])
        }
        
        // generate wrong values
        let longList = genList(6)
        print("longList: \(longList)")
        for i in 0...3 {
            ll_toggle(longList[i], &ll[i])
        }
        
        // generate correct value
        right = GKRandomSource.sharedRandom().nextInt(upperBound: 4)
        ll[right].group = correctSNAddress.group
        mac.genRandom()
        insertMac(mac, &ll[right])
    }
}


func insertMac(_ macAddress: MacAddress, _ addressValue: inout Ipv6Address) -> Void {
    let eui64 = macToEui64(macAddress)
    for i in 4...7 {
        addressValue.group[i] = eui64.group[i]
    }
}


func ll_toggle(_ toggle: Int, _ addressValue: inout Ipv6Address) -> Void {
    switch toggle {
    case 0:
        return ll_quiz0(&addressValue)
    case 1:
        return ll_quiz1(&addressValue)
    case 2:
        return ll_quiz2(&addressValue)
    case 3:
        return ll_quiz3(&addressValue)
    case 4:
        return ll_quiz4(&addressValue)
    case 5:
        return ll_quiz5(&addressValue)
    case 6:
        return ll_quiz6(&addressValue)
    default:
        return ll_quiz0(&addressValue)
    }
}

func ll_quiz0(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[0] = hexToInt("fe88")
}

func ll_quiz1(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[1] = addressValue.group[4]
    addressValue.group[4] = 0
}

func ll_quiz2(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[1] = addressValue.group[4]
    addressValue.group[2] = addressValue.group[5]
    addressValue.group[4] = 0
    addressValue.group[5] = 0
}

func ll_quiz3(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[3] = GKRandomSource.sharedRandom().nextInt(upperBound: 15) + 1
}

func ll_quiz4(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[0] = hexToInt("fe8")
}

func ll_quiz5(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[0] = hexToInt("fe08")
}

func ll_quiz6(_ addressValue: inout Ipv6Address) -> Void {
    addressValue.group[0] = hexToInt("ff80")
}

