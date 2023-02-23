//
//  BTPresenterOutput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation


protocol BTPresenterOutput: AnyObject, BLEManagerObserver  {
    var deviceManager : BLEManager! { get set }
    var detailView: BTPresenterDetailInput! { get set }
    func startScan()
    func connectTo(_ peripheral: BTDisplayPeripheral)
    func searchCharacteristic(from service: BTDisplayService)
}
