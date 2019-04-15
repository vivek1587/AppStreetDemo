//
//  UserDefaults.swift
//  Mirror
//
//  Created by Shailesh Tyagi on 03/08/17.
//  Copyright © 2017 huulke. All rights reserved.
//

import UIKit
import Foundation

class UserDefaultsManager: NSObject {
    
    static let sharedInstance = UserDefaultsManager()
    
    var isLoggedIn:Bool {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.isLoggedIn) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.isLoggedIn) as! Bool
            }
            //Default is not logged in
            return false
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.isLoggedIn)
            kUserDefaults.synchronize()
        }
    }
    
    var isTutorialDone:Bool {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.isTutorialDone) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.isTutorialDone) as! Bool
            }
            return false
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.isTutorialDone)
            kUserDefaults.synchronize()
        }
    }
    
    var isProfileCompleted:Bool {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.isProfileCompleted) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.isProfileCompleted) as! Bool
            }
            return false
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.isProfileCompleted)
            kUserDefaults.synchronize()
        }
    }
    
    var accessToken:String {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.accessToken) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.accessToken) as! String
            }
            return ""
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.accessToken)
            kUserDefaults.synchronize()
        }
    }
    
    func clearCache() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        kUserDefaults.synchronize()
    }
}
