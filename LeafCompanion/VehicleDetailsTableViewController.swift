//
//  VehicleDetailsTableViewController.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/15/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import UIKit

class VehicleDetailsTableViewController: UITableViewController {
    var vehicle: Vehicle!
    var dataSource: [Row: [VehicleDetailTableViewCell.LabelKey: String]]!
    
    enum Row: Int {
        case vin
        case year
        case make
        case model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = vehicle.nickname
        self.dataSource = [
            .vin: [
                .title: "VIN",
                .value: vehicle.vin
            ],
            .year: [
                .title: "Year",
                .value: vehicle.modelYear
            ],
            .make: [
                .title: "Make",
                .value: vehicle.brand.name()
            ],
            .model: [
                .title: "Model",
                .value: vehicle.modelName
            ]
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleDetailCell", for: indexPath) as? VehicleDetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let row = Row.init(rawValue: indexPath.row), let data = self.dataSource[row] {
            cell.titleLabel.text = data[.title]
            cell.valueLabel.text = data[.value]
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
