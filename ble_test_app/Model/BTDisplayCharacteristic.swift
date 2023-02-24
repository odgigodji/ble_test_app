//
//  BTDisplayService.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 23.02.23.
//

import Foundation
import CoreBluetooth
//
//struct BTDisplayService {
//    var isPrimary : Bool
//    var uuid: CBUUID
//    var service: CBService
//    var characteristics: [CBCharacteristic]?
//}

struct BTDisplayCharacteristic {
    var uuid: CBUUID
    var properties : UInt
    var value: Data?
    var notifying: Bool
    var characteristic: CBCharacteristic?
}
