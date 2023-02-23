//
//  BTDisplayService.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 23.02.23.
//

import Foundation
import CoreBluetooth

struct BTDisplayService {
    var isPrimary : Bool
    var uuid: CBUUID
    var service: CBService
}
