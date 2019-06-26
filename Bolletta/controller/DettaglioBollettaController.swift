//
//  DettaglioBollettaController.swift
//  Bolletta
//
//  Created by Patrizio on 09/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit

var tipoBannerDettaglio = "G"
var transazioneScelta: Transazione? = nil

class DettaglioBollettaController: UIViewController {

    @IBOutlet weak var bannerPrezzo: UIImageView!
    
    @IBOutlet weak var PREZZO: UILabel!
    @IBOutlet weak var FORNITORE: UILabel!
    @IBOutlet weak var NOTE: UIView!
    @IBOutlet weak var DATA: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if(transazioneScelta?.tipo == "G"){
            bannerPrezzo.image = UIImage(named: "banner-detail-1")
        }
        if(transazioneScelta?.tipo == "E"){
            bannerPrezzo.image = UIImage(named: "banner-detail-1")
        }
        if(transazioneScelta?.tipo == "GA"){
            bannerPrezzo.image = UIImage(named: "banner-detail-2")
        }
        if(transazioneScelta?.tipo == "T"){
            bannerPrezzo.image = UIImage(named: "banner-detail-3")
        }
        if(transazioneScelta?.tipo == "A"){
            bannerPrezzo.image = UIImage(named: "banner-detail-4")
        }
        // Do any additional setup after loading the view.
        PREZZO.text = transazioneScelta!.importo
        FORNITORE.text = transazioneScelta!.fornitore
        DATA.text = transazioneScelta!.data
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
     */
    @IBAction func torna(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
