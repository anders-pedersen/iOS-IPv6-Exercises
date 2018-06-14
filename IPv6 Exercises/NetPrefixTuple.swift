//
//  NetPrefixTuple.swift
//  IPv6 Exercises
//
//  Created by Anders Pedersen on 29/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation
import GameplayKit

class NetPrefixTuple {
    
    var netPrefix = [NetPrefix]()
    //var testNetPrefix = [NetPrefix]()
    var ipv6Address = Ipv6Address()
    var right: Int = 0
    
    init() {
        for _ in 0 ... 3 {
            netPrefix.append(NetPrefix())
            //testNetPrefix.append(NetPrefix())
        }
    }
    
    func generate() {
        let testNetPrefix = NetPrefix()

        // generate ipv6 address
        ipv6Address.genRandom()
        
        // generate prefix lengths
        let funcPrefixArray = [48,49,50,51,52,53,54,55,56,57,58,59,60,61]
        let funcRandomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: funcPrefixArray.count)
        let prefixLength = funcPrefixArray[funcRandomNumber]
        for i in 0 ... 3 {
            netPrefix[i].prefixLength = prefixLength + i
        }
        
        // generate randomized test set and repeat until at least 1 matches
        
        var match = false
        
        repeat {
            print (".", terminator: "") // debug: see length of calculation
            
            for i in 0 ... 3 {
                netPrefix[i].group = ipv6Address.group
                let groupIndex = Int( Float(netPrefix[i].prefixLength) / 16 )
                let offset = netPrefix[i].prefixLength - (groupIndex * 16)
                let probability = GKRandomSource.sharedRandom().nextInt(upperBound: 10)
                if probability < 8 {
                    netPrefix[i].group[groupIndex] = bitInvert(netPrefix[i].group[groupIndex], (16-offset))
                }
                
                netPrefix[i].truncate(netPrefix[i].prefixLength)
                
//                testNetPrefix[i].group = ipv6Address.group
//                testNetPrefix[i].truncate(netPrefix[i].prefixLength)
                testNetPrefix.group = ipv6Address.group
                testNetPrefix.truncate(netPrefix[i].prefixLength)

                
//                if netPrefix[i].group == testNetPrefix[i].group {
                if netPrefix[i].group == testNetPrefix.group {
                    right = i
                    match = true
                    print("(\(i))", terminator: "") // debug: see all correct options
                }
            }
        } while match == false
    }
}


