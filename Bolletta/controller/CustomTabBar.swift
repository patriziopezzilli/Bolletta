//
//  CustomTabBar.swift
//  Bolletta
//
//  Created by Patrizio on 09/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: ListaController.self) {
            
            tipoUtenza = "G"
            
            navigationeDaTabBar = true
        }
        return true
    }
}
