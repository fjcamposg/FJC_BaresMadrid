//
//  BMListaNoticiasTableViewController.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD


class BMListaNoticiasTableViewController: UITableViewController {

    
    //MARK: - Vbls locales
    
    var arrayNoticias : [BMNoticiasModel] = []
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    @IBOutlet weak var extraMenuButton: UIBarButtonItem!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LLAMADA a DATOS
        
        llamadaNoticias()
        
        
        
        
        
        
        // REGISTRAMOS EL XIB
        
        
        tableView.register(UINib(nibName : "BMNoticiaCustomCell", bundle: nil), forCellReuseIdentifier: "NoticiaCustomCell")
        
        
        
        
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
        return arrayNoticias.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticiaCustomCell", for: indexPath) as! BMNoticiaCustomCell
        let model = arrayNoticias[indexPath.row]
        cell.miTituloNoticia.text = model.title
        cell.miImagenNoticia.kf.setImage(with: URL(string: model.url!),
                                                placeholder: #imageLiteral(resourceName: "placehoder"),
                                                options:nil,
                                                progressBlock: nil,
                                                completionHandler: nil)
        cell.miThumbnailNoticia.kf.setImage(with: URL(string: model.thumbnailUrl!),
                                            placeholder: #imageLiteral(resourceName: "placehoder"),
                                            options:nil,
                                            progressBlock: nil,
                                            completionHandler: nil)
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Utils
    
    func llamadaNoticias(){
        let datosNoticias = BMParserNoticias()
        HUD.show(.progress)
        firstly{
            return when(resolved: datosNoticias.getDatosNoticias())
            }.then {_ in
                self.arrayNoticias = datosNoticias.getParserNoticias()
            }.then {_ in
                self.tableView.reloadData()
            }.then {_ in
                HUD.hide(afterDelay: 0)
            }.catch{ error in
                self.present(muestraAlertVC("ERROR", messageData: "ERROR", titleActionData: "ERROR"), animated: true, completion: nil)
            }
        
    }
   
}
