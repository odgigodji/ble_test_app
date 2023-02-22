//
//  BTObserver.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 22.02.23.
//

import Foundation

protocol BLManagerSubject: AnyObject {
    func attach(_ observer: BLEManagerObserver)
    func detach(_ observer: BLEManagerObserver)
    func notify()
}

protocol BLEManagerObserver: AnyObject {
    func update(subject: BLEManager)
}
