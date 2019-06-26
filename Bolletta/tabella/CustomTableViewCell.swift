//
//  CustomTableViewCell.swift
//  Bolletta
//
//  Created by Patrizio on 08/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit

class Transazione {
    let tipo: String
    let fornitore: String
    let data: String
    let importo: String
    
    init(tipo: String, fornitore: String, data: String, importo: String) {
        self.tipo = tipo
        self.fornitore = fornitore
        self.data = data
        self.importo = importo
    }
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var fornitore: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var prezzo: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
