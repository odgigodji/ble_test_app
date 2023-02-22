//
//  BTPresenterInput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation

protocol BTPresenterInput: AnyObject, Observer {
    var discoveredPeripherals : Set<BTDisplayPeripheral> { get set }
    func showDevices(discoveredPeripherals: Set<BTDisplayPeripheral>)
}
