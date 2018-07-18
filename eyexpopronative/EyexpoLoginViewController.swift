//
//  LoginViewController.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-13.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import Foundation
import ILLoginKit

class EyexpoLoginViewController: UIViewController{
    
    lazy var loginCoordinator: EyexpoLoginCoordinator = {
        return EyexpoLoginCoordinator(rootViewController: self)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserDefaults.standard.value(forKey: "token"){
            showMainScreen();
        }else{
            loginCoordinator.start()
        }
        
    }

    func showMainScreen(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "publictours")
        let appdelegate = UIApplication.shared.delegate!
        let nav = UINavigationController(rootViewController: controller)
        appdelegate.window!!.rootViewController = nav
    }
    
}
