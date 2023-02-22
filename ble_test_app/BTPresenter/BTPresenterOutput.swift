//
//  BTPresenterOutput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation


protocol BTPresenterOutput: AnyObject {
    var deviceManager : BLEManager! { get set }
    func startScan(completed: @escaping (Set<BTDisplayPeripheral>) -> ())
    func updatePeripherals()

}
