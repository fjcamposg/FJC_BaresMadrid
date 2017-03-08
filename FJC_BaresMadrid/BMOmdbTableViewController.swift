//
//  BMOmdbTableViewController.swift
//  FJC_BaresMadrid
//
//  Created by cice on 8/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD


class BMOmdbTableViewController: UITableViewController {

    
    //MARK: - Vbls locales
    
    var idposter = ""
    var arrayDatosOmdb : [BMlmdbModel] = []
    var customRefresh = UIRefreshControl()
    
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var extraMenuButton: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        customRefresh.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        customRefresh.addTarget(self, action: #selector(self.muestraRecarga), for: .valueChanged)
        tableView.addSubview(customRefresh)
        
        
        idposter = String(randomNumero())
        llamadaOmdb()
        
        // REGISTRAMOS EL XIB
        
        
        tableView.register(UINib(nibName : "BMPosterCustomCell", bundle: nil), forCellReuseIdentifier: "BMPosterCustomCell")
        
        
        
        // CREACION de MENU IZQ-DER
        
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            extraMenuButton.target = revealViewController()
            extraMenuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayDatosOmdb.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BMPosterCustomCell", for: indexPath) as! BMPosterCustomCell

        // Configure the cell...
        
        
        let model = arrayDatosOmdb[indexPath.row]
        cell.miTitulo.text = model.title
        cell.miYear.text = model.year
        cell.miId.text = model.imdbID
        cell.miTipo.text = model.type
        
        cell.miImagenPoster.kf.setImage(with: URL(string: model.poster!)
            , placeholder: #imageLiteral(resourceName: "placehoder"),
              options: nil,
              progressBlock: nil,
              completionHandler: nil)
        

        return cell
    }
    
    //MARK: -Utils
    func muestraRecarga(){
        idposter=String(randomNumero())
        llamadaOmdb()
        customRefresh.endRefreshing()
        
    }

    func llamadaOmdb(){
        let datosOmdb = BMParserOmDb()
        HUD.show(.progress)
        firstly{
            return when(resolved: datosOmdb.getDatosOmDb(idposter))
            }.then {_ in
                self.arrayDatosOmdb = datosOmdb.getPaserOmDb()
            }.then {_ in
                self.tableView.reloadData()
            }.then {_ in
                HUD.hide(afterDelay: 0)
            }.catch { error in
                self.present(muestraAlertVC("", messageData: "", titleActionData: ""),animated: true, completion: nil)
        }
    }
    
    func randomNumero() -> Int {
        let dimeNumero = Int(arc4random_uniform(11))
        return dimeNumero
    }
}
