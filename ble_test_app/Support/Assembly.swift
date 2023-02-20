//
//  Assembly.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit

class MainAssembly {
    
    var view                = BTPeriferalTableViewController()
    let presenter           = BTPresenter()
//    let dataManager         = DataManagerImpl()
    
    func createMainPresenter() {
        view.output             = presenter
        
        presenter.view          = view
//        presenter.dataManager   = dataManager
    }
    
}
