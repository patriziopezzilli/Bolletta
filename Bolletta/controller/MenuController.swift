//
//  MenuController.swift
//  Bolletta
//
//  Created by Patrizio on 14/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import Foundation
import UIKit

class MenuController: UITableViewController {
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            print("MOVE to ELETTRICITA")
            tipoUtenza = "E"
            navigationeDaMenu = true
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
            print("MOVE to GAS")
            tipoUtenza = "GA"
            navigationeDaMenu = true
        }
        
        if indexPath.section == 0 && indexPath.row == 2 {
            print("MOVE to TELEFONO")
            tipoUtenza = "T"
            navigationeDaMenu = true
        }
        
        if indexPath.section == 0 && indexPath.row == 3 {
            print("MOVE to ACQUA")
            tipoUtenza = "A"
            navigationeDaMenu = true
        }
    }
}
