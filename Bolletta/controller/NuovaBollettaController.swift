//
//  NuovaBollettaController.swift
//  Bolletta
//
//  Created by Patrizio on 09/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

class NuovaBollettaController: UIViewController{

    @IBOutlet weak var immagineButton: UIImageView!
    
    @IBOutlet weak var aggiungiButton: UIButton!
    
    @IBOutlet weak var FORNITORE: UITextField!
    @IBOutlet weak var IMPORTO: UITextField!
    @IBOutlet weak var DATA: UITextField!
    @IBOutlet weak var NOTE: UITextField!
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        DATA.text = dateFormatter.string(from: sender.date)
    }
    
    override func viewDidLoad() {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        
        DATA.inputView = datePickerView
        
        super.viewDidLoad()
        
        self.view.hero.id = "nuovaBolletta"

        if(tipoUtenza == "G"){
            immagineButton.image = UIImage(named: "banner-detail-1")
            aggiungiButton.setTitle("Aggiungi bolletta elettrica", for: .normal)
        }
        if(tipoUtenza == "E"){
            immagineButton.image = UIImage(named: "banner-detail-1")
            aggiungiButton.setTitle("Aggiungi bolletta elettrica", for: .normal)
        }
        if(tipoUtenza == "GA"){
            immagineButton.image = UIImage(named: "banner-detail-2")
            aggiungiButton.setTitle("Aggiungi bolletta GAS", for: .normal)
        }
        if(tipoUtenza == "T"){
            immagineButton.image = UIImage(named: "banner-detail-3")
            aggiungiButton.setTitle("Aggiungi bolletta telefonica", for: .normal)
        }
        if(tipoUtenza == "A"){
            immagineButton.image = UIImage(named: "banner-detail-4")
            aggiungiButton.setTitle("Aggiungi bolletta acqua", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func annulla(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nuovaTransazione(_ sender: Any){
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        let myDate : String = formatter.string(from:   NSDate.init(timeIntervalSinceNow: 0) as Date)
        
        var nuovaTransazione = Transazione(tipo: tipoUtenza, fornitore: FORNITORE.text!, data: DATA.text!, importo: IMPORTO.text! + "€")
        
        if(tipoUtenza == "E"){
            elettricita_transazioni.append(nuovaTransazione)
        }
        if(tipoUtenza == "GA"){
            gas_transazioni.append(nuovaTransazione)
        }
        if(tipoUtenza == "T"){
            telefono_transazioni.append(nuovaTransazione)
        }
        if(tipoUtenza == "A"){
            acqua_transazioni.append(nuovaTransazione)
        }
        
        navigationeDaTabBar = true
        dismiss(animated: true, completion: nil)
    }
}
