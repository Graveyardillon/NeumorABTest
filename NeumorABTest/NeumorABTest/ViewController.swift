//
//  ViewController.swift
//  NeumorABTest
//
//  Created by Papillon on 2020/02/20.
//  Copyright © 2020 Papillon. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var remoteConfig: RemoteConfig!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults(fromPlist: "RemoteConfig")
        
        statusLabel.text = self.remoteConfig["loading_phrase"].stringValue
        
        remoteConfig.fetch(completionHandler: { (status, error) in
            if status == .success {
                print("Config fetched")
                self.remoteConfig.activate(completionHandler: { (error) in
                    
                })
            } else {
                print("Config not fetched")
            }
        })
        
        self.displayWelcome()
    }
    
    private func displayWelcome() {
        var welcomeMessage = self.remoteConfig["welcome_message"].stringValue
        
        if remoteConfig["welcome_message_caps"].boolValue {
            welcomeMessage = welcomeMessage?.uppercased()
        }
        statusLabel.text = welcomeMessage
    }
    
    @IBAction func testA(_ sender: Any) {
        print("testA")
    }
    
    @IBAction func testB(_ sender: Any) {
        print("testB")
    }
    
}

