//
//  BTPresenterOutput.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation


protocol BTPresenterOutput: AnyObject, BLEManagerObserver  {
    var deviceManager : BLEManager! { get set }
    func startScan()
//    func update(subject: BLEManager) 
}
