//
//  BTCharacteristicTableViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 24.02.23.
//

import UIKit

class BTCharacteristicTableViewController: UITableViewController {

    var characteristic : BTDisplayCharacteristic!
    weak var delegate: BTDeviceTableViewController!
    
    init(characteristic: BTDisplayCharacteristic!, delegate: BTDeviceTableViewController) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
        self.characteristic = characteristic
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }

    func configureVC() {
        navigationItem.title = characteristic.uuid.debugDescription
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "WRITE"
                delegate.output.writeCharacteristic()
            case 1:
                let string = String(data: characteristic.value ?? Data(), encoding: .utf8)
                cell.textLabel?.text = "(\(characteristic.value?.debugDescription ?? "nil"))  \(string ?? " ")"
            default:
                cell.textLabel?.text = "test value "
            }
        case 1:
            cell.textLabel?.text = characteristic.notifying ? "subscribe" : "not supporting"
        default:
            cell.textLabel?.text = "her "
//            cell.textLabel?.text = !characteristics.isEmpty ? characteristics[indexPath.row].uuid.debugDescription : "echo"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "VALUE"
        case 1:
            return "NOTIFY VALUE"
        case 2:
            return "DESCRIPTOR"
        default:
            return "n/a"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
//                print("write")
                delegate.output.writeCharacteristic()
            } else {
                delegate.output.readCharacteristic(characteristic)
            }
//            processingSelectionRow(indexPath: indexPath)
        default:
            return
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
