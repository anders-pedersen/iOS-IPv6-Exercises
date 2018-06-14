//
//  ipv6Classes.swift
//  IP Prefix Sizes
//
//  Created by Anders Pedersen on 26/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation
import GameplayKit

class Ipv6Address {
    var group: [Int]
    var firstZero, lastZero: Int?
    
    init() {
        group = [0,0,0,0, 0,0,0,0]
    }
    
    func string() -> String {
        var stringValue = ""
        
        determineZeroInterval()
        
        
        if self.lastZero != nil { // if address include zero interval
            if self.firstZero! > 0 {
                for i in 0...(self.firstZero! - 1) {
                    stringValue += intToHex(group[i]) + ":"
                }
            } else {
                stringValue += ":"
            }
            
            if self.lastZero! < 7 {
                for i in (self.lastZero! + 1)...7 {
                    stringValue += ":" + intToHex(group[i])
                }
            } else {
                stringValue += ":"
            }
        }
        
    
    
        if self.lastZero == nil { // if address doesn't include zero interval
            for i in 0...7 {
                stringValue += intToHex(group[i]) + ":"
            }
            stringValue.remove(at: stringValue.index(before: stringValue.endIndex))
        }
        
        
        return stringValue
    }
    
    func ifIdString() -> String {
        var stringValue = ""
        for i in 4...7 {
            stringValue += intToHex(group[i]) + ":"
        }
        stringValue.remove(at: stringValue.index(before: stringValue.endIndex))
        return stringValue
    }
    
    func determineZeroInterval() {
        lastZero = nil
        for i in 0...6 {
            if group[i] == 0 && group[i+1] == 0 {
                firstZero = i
                break
            }
        }
        if firstZero != nil {
            for i in firstZero!...7 {
                if group[i] == 0  {
                    lastZero = i
                } else {
                    break
                }
            }
        }
    }
    
    func genRandom() {
        // 2001:0000/23 etc. - 2001:20::/28 reserved for various - 2016(16) = 8193(10)
        // 2001:db8::/32 reserved for documentation - db8(16) = 3512(10)
        
        group[0] = 8193
        group[1] = GKRandomSource.sharedRandom().nextInt(upperBound: (65534 - 4096)) + 4096 + 2
        group[2] = GKRandomSource.sharedRandom().nextInt(upperBound: 65534) + 2
        group[3] = GKRandomSource.sharedRandom().nextInt(upperBound: 65534) + 2

        group[4] = 0
        group[5] = 0
        group[6] = 0
        group[7] = GKRandomSource.sharedRandom().nextInt(upperBound: 1023) + 2
    }
    
    func truncate(_ prefixValue: Int) {
        if prefixValue <= 8 || prefixValue >= 64 { return }
        let groupIndex = Int( Float(prefixValue) / 16 )
        let networkv6Address = Networkv6Address()
        networkv6Address.genFromPrefixLength(prefixValue)
        group[groupIndex] = (group[groupIndex]  & networkv6Address.group[groupIndex])
        
        // it is assumed that groupIndex is equal to 0, 1,2 or 3
        if groupIndex <= 2 { group[3] = 0 }
        if groupIndex <= 1 { group[2] = 0 }
        if groupIndex == 0 { group[1] = 0 }
    }
    
}

class Networkv6Address: Ipv6Address {
   
    func genFromPrefixLength (_ prefix: Int) {
        group = [0,0,0,0, 0,0,0,0] // set all bytes to zero
        
        let index = Int(Float(prefix) / 16) // set leading bytes to ffff
        for i in 0...(index - 1) { group[i] = hexToInt("ffff") }
        
        var modBinGroup = "" // calculate value for middle byte as binary
        let modus = prefix % 16
        for i in 0...15 {
            if i < modus { modBinGroup += "1" } else { modBinGroup += "0" }
        }
        
        group[index] = binToInt(modBinGroup) // convert to decimal
    }
}

class MacAddress {
    var byte: [Int]
    init() {
        byte = [0,0,0, 0,0,0]
    }
    func genRandom() {
        for i in 0...5 {
            byte[i] = GKRandomSource.sharedRandom().nextInt(upperBound: 255)
        }
        byte[0] = bit7Unset(byte[0])
    }
    
    func string() -> String {
        var StringValue = int8ToHex(byte[0]) + "-" + int8ToHex(byte[1]) + "-" + int8ToHex(byte[2])
        StringValue += "-" + int8ToHex(byte[3]) + "-" + int8ToHex(byte[4]) + "-" + int8ToHex(byte[5])
        return StringValue
    }
    
}

class NetPrefix: Ipv6Address {
    var prefixLength: Int = 64
}







