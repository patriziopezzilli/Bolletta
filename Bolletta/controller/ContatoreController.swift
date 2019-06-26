//
//  FirstViewController.swift
//  Bolletta
//
//  Created by Patrizio on 07/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit

var tipoUtenza = "G"

class ContatoreController: UIViewController {

    @IBOutlet weak var mediaElett: UILabel!
    @IBOutlet weak var mediaGAS: UILabel!
    @IBOutlet weak var mediaAQ: UILabel!
    @IBOutlet weak var mediaTEL: UILabel!
    
    @IBAction func sceltaElettricità(_ sender: Any) {
        tipoUtenza = "E"
        navigationeDaMenu = false
        navigationeDaTabBar = false
    }

    @IBAction func sceltaGAS(_ sender: Any) {
        tipoUtenza = "GA"
        navigationeDaMenu = false
        navigationeDaTabBar = false
    }

    @IBAction func sceltaTelefono(_ sender: Any) {
        tipoUtenza = "T"
        navigationeDaMenu = false
        navigationeDaTabBar = false
    }
    
    @IBAction func sceltaAcqua(_ sender: Any) {
        tipoUtenza = "A"
        navigationeDaMenu = false
        navigationeDaTabBar = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        // media elettr
        if(elettricita_transazioni.count > 0) {
            mediaElett.text = String.init(mediaArit(array: elettricita_transazioni))
        } else {
            mediaElett.text = "N/A"
        }
        
        if(gas_transazioni.count > 0) {
            mediaGAS.text = String.init(mediaArit(array: gas_transazioni))
        } else {
            mediaGAS.text = "N/A"
        }
        
        if(telefono_transazioni.count > 0) {
            mediaTEL.text = String.init(mediaArit(array: telefono_transazioni))
        } else {
            mediaTEL.text = "N/A"
        }
        
        if(acqua_transazioni.count > 0) {
            mediaAQ.text = String.init(mediaArit(array: acqua_transazioni))
        } else {
            mediaAQ.text = "N/A"
        }
    }
}

func mediaArit(array: [Transazione]) -> String{
    var elemArr: Int
    var sommaElem: Double = 0
    elemArr = array.count
    for i in array{
        var importoDef: String = i.importo.replacingOccurrences(of: "€", with: "")
        importoDef = importoDef.replacingOccurrences(of: ",", with: ".")
        sommaElem += Double.init(importoDef)!
    }
    var result: String = String.init(sommaElem/Double(elemArr))
    
    if(result.count > 4) {
        result = String(result[...result.index(result.startIndex, offsetBy: 4)])
    }
    return result + "€"
}

