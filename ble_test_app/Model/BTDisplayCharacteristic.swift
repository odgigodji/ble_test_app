//
//  BTDisplayService.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 23.02.23.
//

import Foundation
import CoreBluetooth


struct BTDisplayCharacteristic {
    var uuid: CBUUID
    var properties : UInt
    var value: Data?
    var notifying: Bool
    var characteristic: CBCharacteristic?
}
