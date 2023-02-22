//
//  BTDisplayPeripheral.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 21.02.23.
//

import Foundation
import CoreBluetooth

struct BTDisplayPeripheral: Hashable {
    let peripheral: CBPeripheral
    let lastRSSI: NSNumber
    let isConnectable: Bool
    
    static func ==(lhs: BTDisplayPeripheral, rhs: BTDisplayPeripheral) -> Bool {
//        if lhs.peripheral == rhs.peripheral && lhs.lastRSSI == lhs.lastRSSI {
//           return true
//        } else {
//            return false
//        }
        return lhs.peripheral == rhs.peripheral
    }
    
    func hash(into hasher: inout Hasher) { }
}
