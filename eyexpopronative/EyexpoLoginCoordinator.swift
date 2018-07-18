//
//  LoginCoordinator.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-13.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import Foundation
import ILLoginKit
import SwiftyJSON

class EyexpoLoginCoordinator: ILLoginKit.LoginCoordinator {
    
    // MARK: - LoginCoordinator
    
    override func start(animated: Bool = true) {
        configureAppearance()
        super.start(animated: animated)
    }
    
    override func finish(animated: Bool = true) {
        super.finish(animated: animated)
    
        let loginVC = self.rootViewController as! EyexpoLoginViewController
        loginVC.showMainScreen()
        
    }
    
    // MARK: - Setup
    
    // Customize LoginKit. All properties have defaults, only set the ones you want.
    func configureAppearance() {
        configuration.shouldShowSignupButton = false
        configuration.shouldShowFacebookButton = false
        configuration.shouldShowForgotPassword = false
        configuration.tintColor = UIColor(red: 1, green: 152.0/255.0, blue: 0, alpha: 1)
        configuration.errorTintColor = UIColor.red
        configuration.backgroundImage = UIImage(named: "demoNA")!
    }
    
    // MARK: - Completion Callbacks
    
    // Handle login via your API
    override func login(email: String, password: String) {
        print("Login with: email =\(email) password = \(password)")
        NetworkManager.shared.login(email: email, password: password) { (err, succ) in
            
            if let err = err
            {
                let errJson = JSON(err )
                print(errJson)
                if  let errMsg = errJson["message"].string,
                    let loginKitVC = self.visibleViewController() as? LoginViewController {
                    loginKitVC.emailTextField.errorMessage = errMsg
                }
            }else if let succ = succ
            {
                let data = JSON(succ)
                UserDefaults.standard.setValue(data["token"].stringValue, forKeyPath: "token")
                UserDefaults.standard.synchronize()
                self.finish(animated: true)
            }
            
        }
    }
    
    // Handle signup via your API
    override func signup(name: String, email: String, password: String) {
        print("Signup with: name = \(name) email =\(email) password = \(password)")
    }
    
    // Handle Facebook login/signup via your API
    override func enterWithFacebook(profile: FacebookProfile) {
        print("Login/Signup via Facebook with: FB profile =\(profile)")
    }
    
    // Handle password recovery via your API
    override func recoverPassword(email: String) {
        print("Recover password with: email =\(email)")
    }
    
}
