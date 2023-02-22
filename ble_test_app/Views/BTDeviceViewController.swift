//
//  BTDeviceViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 22.02.23.
//

import UIKit

class BTDeviceViewController: UIViewController {

    var peripheral: BTDisplayPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
//        navigationItem.title = "N/A"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.topItem?.title = "her"
    }
    
    func setVC(with peripheral: BTDisplayPeripheral) {
        self.peripheral = peripheral
//        navigationItem.title = peripheral.peripheral.name
        navigationItem.title = peripheral.peripheral.name ?? "N/A"
        
//        navigationController?.navigationBar.topItem?.title = "her"
    }
    
}
