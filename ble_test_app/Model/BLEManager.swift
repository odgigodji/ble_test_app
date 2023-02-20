//
//  BLEManager.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation
import CoreBluetooth

protocol BLEManager: AnyObject {
    var centralManager: CBCentralManager! { get set }
    
    
}
