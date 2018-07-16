//
//  HomeViewController.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/15/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var vehicleButton: UIButton!
    @IBOutlet weak var chargingImageView: UIImageView!
    
    var connectApi: ConnectApi!
    var vehicles: [Vehicle]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vehicles = DataStorage.retrieve("vehicles.json", as: [Vehicle].self)
        if let vehicle = vehicles?.first {
            let imageName = vehicle.isPluggedIn ? "MorningSkyBluePluggedIn" : "GunMetallic"
            self.vehicleButton.imageView?.image = UIImage(named: imageName)
            self.chargingImageView.isHidden = !vehicle.isCharging
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVehicleDetails", let navigationController = segue.destination as? UINavigationController, let vehicleDetailsTableViewController = navigationController.topViewController as? VehicleDetailsTableViewController {
            vehicleDetailsTableViewController.vehicle = vehicles.first
        }
    }
}
