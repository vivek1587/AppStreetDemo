//
//  ConfigurationManager.swift
//  Mirror
//
//  Created by Shailesh Tyagi on 03/08/17.
//  Copyright © 2017 huulke. All rights reserved.
//

import Foundation
import UIKit

let kEnvironmentsPlist:NSString? = "Environments"
let kConfigurationKey:NSString? = "ActiveConfiguration"
let kAPIEndpointKey:NSString? = "APIEndPoint"

class ConfigurationManager:NSObject {
    
    var environment : NSDictionary?
    
    //Singleton Method
    
    static let sharedManager: ConfigurationManager = {
        let instance = ConfigurationManager()
        // setup code
        return instance
    }()
       
    override init() {
        super.init()
        initialize()
    }
    
    // Private method
    
    func initialize ()   {
        
        var environments: NSDictionary?
        if let envsPlistPath = Bundle.main.path(forResource: kEnvironmentsPlist! as String, ofType: "plist") {
            environments = NSDictionary(contentsOfFile: envsPlistPath)
        }
        self.environment = environments!.object(forKey: currentConfiguration()) as? NSDictionary
        if self.environment == nil {
            assertionFailure(NSLocalizedString("Unable to load application configuration", comment: "Unable to load application configuration"))
        }
    }
    
    // currentConfiguration
    
    func currentConfiguration () -> String   {
        let configuration = Bundle.main.infoDictionary?[kConfigurationKey! as String] as? String
        return configuration!
    }
    
    // APIEndpoint
    
    func APIEndpoint () -> String  {
        let configuration = self.environment![kAPIEndpointKey!]
        return configuration as! String
    }
}
