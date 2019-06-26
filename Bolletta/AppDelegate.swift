//
//  AppDelegate.swift
//  Bolletta
//
//  Created by Patrizio on 07/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // recupera liste
        if(nil != defaults.array(forKey: "E")) {
            elettricita_transazioni = defaults.array(forKey: "E") as! [Transazione]
        }
        
        if(nil != defaults.array(forKey: "G")) {
        gas_transazioni = defaults.array(forKey: "G") as! [Transazione]
        }
        
        if(nil != defaults.array(forKey: "A")) {
        acqua_transazioni = defaults.array(forKey: "A") as! [Transazione]
        }
        
        if(nil != defaults.array(forKey: "T")) {
        telefono_transazioni = defaults.array(forKey: "T") as! [Transazione]
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // salva liste
        defaults.set(elettricita_transazioni, forKey: "E")
        defaults.set(gas_transazioni, forKey: "G")
        defaults.set(acqua_transazioni, forKey: "A")
        defaults.set(telefono_transazioni, forKey: "T")
        
        defaults.synchronize()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // salva liste
        defaults.set(elettricita_transazioni, forKey: "E")
        defaults.set(gas_transazioni, forKey: "G")
        defaults.set(acqua_transazioni, forKey: "A")
        defaults.set(telefono_transazioni, forKey: "T")
        
        defaults.synchronize()
    }


}

