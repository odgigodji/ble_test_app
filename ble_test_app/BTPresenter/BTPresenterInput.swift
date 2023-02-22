//
//  BTPresenterInput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation

protocol BTPresenterInput: AnyObject {
    var discoveredPeripherals : [BTDisplayPeripheral] { get set }
    func updatePeripheralsOnTableView(peripherals: [BTDisplayPeripheral])
}
