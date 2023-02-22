//
//  BTObserver.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 22.02.23.
//

import Foundation

protocol BLEManagerObserver: AnyObject {
    func update(subject: BLEManager)
}
