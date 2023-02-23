//
//  BTPresenterInput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation

protocol BTPresenterMainInput: AnyObject {
//    var discoveredPeripherals : [BTDisplayPeripheral] { get set }
    func updatePeripheralsOnTableView(peripherals: [BTDisplayPeripheral])
}

protocol BTPresenterDetailInput: AnyObject {
    func setVC(with peripheral: BTDisplayPeripheral)
    func updateVC(services: [BTDisplayService])
//    func updateServicesOnTableView(peripherals: [BTDisplayPeripheral])
}
