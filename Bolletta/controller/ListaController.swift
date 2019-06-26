//
//  SecondViewController.swift
//  Bolletta
//
//  Created by Patrizio on 07/06/2019.
//  Copyright © 2019 Patrizio. All rights reserved.
//

import UIKit


var presentedVC: UIViewController?

var navigationeDaMenu = false
var navigationeDaTabBar = false

var chartAvailable = true

var elettricita_transazioni : [Transazione] = []
var gas_transazioni : [Transazione] = []
var telefono_transazioni : [Transazione] = []
var acqua_transazioni : [Transazione] = []

var transazioni : [Transazione] = []

class ListaController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChartDelegate {
    
    @IBOutlet weak var MEDIA: UILabel!
    
    @IBOutlet weak var percentualeMese: UILabel!
    
    @IBOutlet weak var noContentView: UIView!
    @IBOutlet weak var titolo: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottoneInAlto: UIButton!
    @IBOutlet weak var tabella: UITableView!
    @IBOutlet weak var chart: Chart!
    
    override func viewDidAppear(_ animated: Bool) {
        if(navigationeDaTabBar) {
            viewDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.hero.id = "nuovaBolletta"
        
        checkAddButton()
        
        // define title
        if(tipoUtenza == "G"){
            titolo.text = "Bollette"
            
            bottoneInAlto.setTitle("Categorie", for: .normal)
            
            transazioni = elettricita_transazioni + acqua_transazioni + telefono_transazioni + gas_transazioni
            
        }
        if(tipoUtenza == "E"){
            titolo.text = "Elettricità"
            
            if(navigationeDaMenu) {
                bottoneInAlto.setTitle("Categorie", for: .normal)
            }
            
            transazioni = elettricita_transazioni
        }
        if(tipoUtenza == "GA"){
            titolo.text = "GAS"
            
            if(navigationeDaMenu) {
                bottoneInAlto.setTitle("Categorie", for: .normal)
            }
            
            transazioni = gas_transazioni
        }
        if(tipoUtenza == "T"){
            titolo.text = "Telefono"
            
            if(navigationeDaMenu) {
                bottoneInAlto.setTitle("Categorie", for: .normal)
            }
            
            transazioni = telefono_transazioni
        }
        if(tipoUtenza == "A"){
            titolo.text = "Acqua"
            
            if(navigationeDaMenu) {
                bottoneInAlto.setTitle("Categorie", for: .normal)
            }
            
            transazioni = acqua_transazioni
        }
        
        if(transazioni.count == 0) {
            percentualeMese.text = "N/A"
            
            noContentView.isHidden = false
        } else {
            noContentView.isHidden = true
            
            initializeChart()
        }
        
        tabella.dataSource = self
        tabella.delegate = self

        tabella.reloadData()
        
        // calc media
        if(transazioni.count > 0) {
            MEDIA.text = mediaArit(array: transazioni)
        } else {
            MEDIA.text = "N/A"
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(!segue.destination.isKind(of: DettaglioBollettaController.self)){
            let navigationVC = segue.destination as! UINavigationController
            let rootVC = navigationVC.viewControllers.first!
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hide))
            
            rootVC.navigationItem.title = ""
            rootVC.navigationItem.rightBarButtonItem = doneButton
        } else {
            let selectedIndex = self.tabella.indexPath(for: sender as! UITableViewCell)
            transazioneScelta = transazioni[(selectedIndex?.item)!]
        }
    }
    
    @objc private func hide() {
        dismiss(animated: true, completion: nil)
        viewDidLoad()
    }
    @IBAction func closeModal(_ sender: Any) {
        
        if(tipoUtenza != "G" && !navigationeDaMenu){
            dismiss(animated: true, completion: nil)
        } else {
            //mostrare menu con categorie
            let childVC = storyboard!.instantiateViewController(withIdentifier: "menu")
            let segue = BottomCardSegue(identifier: nil, source: self, destination: childVC)
            prepare(for: segue, sender: nil)
            segue.perform()
        }
        
    }
    
    func checkAddButton() {
        if(tipoUtenza == "G") {
            addButton.isHidden = true
        } else {
            addButton.isHidden = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transazioni.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        print("Populate row: " + String.init(indexPath.item));
              
        cell.fornitore.text = transazioni[indexPath.item].fornitore
        cell.data.text = transazioni[indexPath.item].data
        cell.prezzo.text = transazioni[indexPath.item].importo
        
        let utenza = transazioni[indexPath.item].tipo
        if(utenza == "G"){
            cell.imageBackground.image = UIImage(named: "banner-detail-1")
        }
        if(utenza == "E"){
            cell.imageBackground.image = UIImage(named: "banner-detail-1")
        }
        if(utenza == "GA"){
            cell.imageBackground.image = UIImage(named: "banner-detail-2")
        }
        if(utenza == "T"){
            cell.imageBackground.image = UIImage(named: "banner-detail-3")
        }
        if(utenza == "A"){
            cell.imageBackground.image = UIImage(named: "banner-detail-4")
        }
        
        cell.imageBackground.layer.zPosition = -5;
    
        return cell
    }

    func initializeChart() {
        chart.delegate = self
        
        // Initialize data series and labels
        let stockValues = getStockValues()
        
        var serieData: [Double] = []
        var labels: [Double] = []
        var labelsAsString: Array<String> = []
        
        // Date formatter to retrieve the month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        
        for (i) in transazioni {
            
            var importoC = i.importo.replacingOccurrences(of: "€", with: "")
            importoC = importoC.replacingOccurrences(of: ",", with: ".")
            serieData.append(Double(importoC) as! Double)
            
            // Use only one label for each month
            let cal = Calendar.current
            let formatter : DateFormatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yy"
            
            let month = cal.component(.month, from: formatter.date(from: i.data)!)
            let monthAsString:String = dateFormatter.monthSymbols[month - 1]
            if (labels.count == 0 || labelsAsString.last != monthAsString) {
                labels.append(Double(importoC) as! Double)
                labelsAsString.append(monthAsString)
            }
        }
        
        let series = ChartSeries(serieData)
        series.area = true
        
        // Configure chart layout
        
        chart.lineWidth = 0.5
        chart.labelFont = UIFont.systemFont(ofSize: 12)
        chart.xLabels = labels
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        chart.xLabelsTextAlignment = .center
        chart.yLabelsOnRightSide = true
        // Add some padding above the x-axis
        if(serieData.count > 0){
            chart.minY = serieData.min()! - 5
            chartAvailable = true
        } else {
            chart.minY = 0
            chartAvailable = false
        }
        
        chart.add(series)
        
    }
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    
    func getStockValues() -> Array<Dictionary<String, Any>> {
        
        // Read the JSON file
        let filePath = Bundle.main.path(forResource: "AAPL", ofType: "json")!
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        let json: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSDictionary
        let jsonValues = json["quotes"] as! Array<NSDictionary>
        
        // Parse data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let values = jsonValues.map { (value: NSDictionary) -> Dictionary<String, Any> in
            let date = dateFormatter.date(from: value["date"]! as! String)
            let close = (value["close"]! as! NSNumber).doubleValue
            return ["date": date!, "close": close]
        }
        
        return values
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "nuovaBollettaController") as! UIViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(view, animated: false, completion: nil)
        
    }
}

