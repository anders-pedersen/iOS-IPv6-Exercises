//
//  Tuplev6Classes.swift
//  IPv6 Exercises
//
//  Created by Anders Pedersen on 28/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation
import GameplayKit


class Eui64Tuple {
    
    var eui64 = [Ipv6Address]()
    var mac = MacAddress()
    var right: Int
    
    init() {
        right = 0
        for _ in 0 ... 3 {
            eui64.append(Ipv6Address())
        }
    }

    func generate() {
        // generate correct MAC address
        mac.genRandom()
        mac.byte[0] = bit7Unset(mac.byte[0])
        
        // generate incorrect values
        let longList = genList(4)
        for i in 0 ... 3 {
            eui64[i].group = macToEui64_toggle(longList[i], mac).group
        }
        
        // generate correct value
        right = GKRandomSource.sharedRandom().nextInt(upperBound: 4)
        eui64[right].group = macToEui64(mac).group
    }
}




func macToEui64_toggle (_ toggle: Int, _ mac: MacAddress) -> Ipv6Address {
    switch toggle {
    case 0:
        return macToEui64_quiz0(mac)
    case 1:
        return macToEui64_quiz1(mac)
    case 2:
        return macToEui64_quiz2(mac)
    case 3:
        return macToEui64_quiz3(mac)
    case 4:
        return macToEui64_quiz4(mac)
    default:
        return macToEui64_quiz0(mac)
    }
}

func macToEui64_quiz0(_ mac: MacAddress) -> Ipv6Address {
    let result = Ipv6Address()
    result.group[4] = mac.byte[0] * 256 + mac.byte[1]
    result.group[5] = bit7Set(mac.byte[2]) * 256 + hexToInt("ff")
    result.group[6] = hexToInt("fe") * 256 + mac.byte[3]
    result.group[7] = mac.byte[4] * 256 + mac.byte[5]
    return result
}

func macToEui64_quiz1(_ mac: MacAddress) -> Ipv6Address {
    let result = Ipv6Address()
    result.group[4] = bit6Set(mac.byte[0]) * 256 + mac.byte[1]
    result.group[5] = mac.byte[2] * 256 + hexToInt("ff")
    result.group[6] = hexToInt("fe") * 256 + mac.byte[3]
    result.group[7] = mac.byte[4] * 256 + mac.byte[5]
    return result
}

func macToEui64_quiz2(_ mac: MacAddress) -> Ipv6Address {
    let result = Ipv6Address()
    result.group[4] = mac.byte[0] * 256 + bit7Set(mac.byte[1])
    result.group[5] = mac.byte[2] * 256 + hexToInt("ff")
    result.group[6] = hexToInt("fe") * 256 + mac.byte[3]
    result.group[7] = mac.byte[4] * 256 + mac.byte[5]
    return result
}

func macToEui64_quiz3(_ mac: MacAddress) -> Ipv6Address {
    let result = Ipv6Address()
    result.group[4] = mac.byte[0] * 256 + mac.byte[1]
    result.group[5] = mac.byte[2] * 256 + hexToInt("ff")
    result.group[6] = hexToInt("fe") * 256 + mac.byte[3]
    result.group[7] = mac.byte[4] * 256 + mac.byte[5]
    return result
}

func macToEui64_quiz4(_ mac: MacAddress) -> Ipv6Address {
    let result = Ipv6Address()
    result.group[4] = bit7Set(mac.byte[0]) * 256 + mac.byte[1]
    result.group[5] = mac.byte[2] * 256 + hexToInt("fe")
    result.group[6] = hexToInt("ff") * 256 + mac.byte[3]
    result.group[7] = mac.byte[4] * 256 + mac.byte[5]
    return result
}








