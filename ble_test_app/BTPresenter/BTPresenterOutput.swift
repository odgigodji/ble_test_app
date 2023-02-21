//
//  BTPresenterOutput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation


protocol BTPresenterOutput: AnyObject {
    func startScan(completed: @escaping (Set<BTDisplayPeripheral>) -> ())
    func updatePeripherals()
}
