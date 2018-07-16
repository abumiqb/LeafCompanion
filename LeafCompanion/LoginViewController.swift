//
//  ViewController.swift
//  LeafCompanion
//
//  Created by Matthew Mohrman on 5/11/18.
//  Copyright © 2018 Matthew Mohrman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var connectApi: ConnectApi!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logInButtonTapped(_ sender: UIButton) {
        self.connectApi.authenticate(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "") { result in
            do {
                let vehicles = try result.unwrap()
                print(vehicles)
                DataStorage.store(vehicles, as: "vehicles.json")
                
                guard let navigationViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AuthenticatedFlow") as? UINavigationController, let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    // Display error
                    return
                }
                
                appDelegate.window?.rootViewController = navigationViewController
            } catch let error {
                debugPrint("Authenticate error: \(error.localizedDescription)")
            }
        }
    }
}

