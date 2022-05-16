//
//  ConversionClasses.swift
//  IPv6 Exercises
//
//  Created by Anders Pedersen on 27/04/2017.
//  Copyright © 2017 Anders Pedersen. All rights reserved.
//

import Foundation

func intToHex(_ intValue: Int) -> String {
    let hexValue = String(intValue, radix: 16)
    return hexValue
}

func hexToInt(_ stringValue: String) -> Int {
    if let intValue = Int(stringValue, radix:16) {
        return intValue
    } else {
        return 0
    }
}

func binToInt(_ stringValue: String) -> Int {
    if let intValue = Int(stringValue, radix:2) {
        return intValue
    } else {
        return 0
    }
}

func int8ToHex(_ intValue: Int) -> String {
    var hexValue = String(intValue, radix: 16)
    if hexValue.count == 1 { hexValue = "0" + hexValue }
    return hexValue
}

func bit7Unset(_ intValue: Int) -> Int {
    var returnValue = intValue
    let binValue = String(intValue, radix: 2)
    if binValue.count >= 2 {
        let index = binValue.index(binValue.endIndex, offsetBy:-2)
        if binValue[index] == "1" { returnValue = intValue - 2 }
    }
    return returnValue
}

func bit7Set(_ intValue: Int) -> Int {
    var returnValue = intValue
    let binValue = String(intValue, radix: 2)
    if binValue.count >= 2 {
        let index = binValue.index(binValue.endIndex, offsetBy:-2)
        if binValue[index] == "0" { returnValue = intValue + 2 }
    } else {
        returnValue = intValue + 2
    }
    return returnValue
}

func bit6Set(_ intValue: Int) -> Int {
    var returnValue = intValue
    let binValue = String(intValue, radix: 2)
    if binValue.count >= 3 {
        let index = binValue.index(binValue.endIndex, offsetBy:-3)
        if binValue[index] == "0" { returnValue = intValue + 4 }
    }
    return returnValue
}

func macToEui64(_ mac: MacAddress) -> Ipv6Address {
    let result = Ipv6Address()
    result.group[4] = bit7Set(mac.byte[0]) * 256 + mac.byte[1]
    result.group[5] = mac.byte[2] * 256 + hexToInt("ff")
    result.group[6] = hexToInt("fe") * 256 + mac.byte[3]
    result.group[7] = mac.byte[4] * 256 + mac.byte[5]
    return result
}

func truncInt16(intInput: Int, prefixLength: Int) -> Int {
    let networkv6Address = Networkv6Address()
    networkv6Address.genFromPrefixLength(prefixLength)
    print("Prefix: " + networkv6Address.string())
    return 0
}

func bitInvert(_ inputInt: Int, _ inputIndex: Int) -> Int {
    // invert the bit at the index position (from right)
    let changeValue = Int(pow(2, Double(inputIndex)))
    return (inputInt ^ changeValue) // xor
}

