//
//  BMDetalleBarViewController.swift
//  FJC_BaresMadrid
//
//  Created by cice on 13/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

//TODO: - Fase 1 delegado
protocol BMDetalleBarViewControllerDelegate{
    func bmBaresEtiquetados(_ detalleVC : BMDetalleBarViewController, barEtiquetado : BMBaresModel)
    
}

class BMDetalleBarViewController: UIViewController {

    // MARK: - Vbles locales
    
    var detallebarMadrid : BMBaresModel?
    
    
    //TODO: - Fase 2 delegado
    
    var bmDelegate : BMDetalleBarViewControllerDelegate?
    
    
    
    // MARK: - Otlets
    
    
    @IBOutlet weak var miImageViewPicker: UIImageView!
    
    @IBOutlet weak var miLatitud: UILabel!
    
    @IBOutlet weak var miLongitud: UILabel!
    
    @IBOutlet weak var miDireccion: UILabel!
    
    
    @IBOutlet weak var miSalvardatosBTN: UIBarButtonItem!
    
    
    // MARK: - aCtions
    
    
    @IBAction func cerrarVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func salvarFotografia(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: - PickerView
        
        miImageViewPicker.isUserInteractionEnabled = true
        let tomaFotoGR = UITapGestureRecognizer(target: self, action: #selector(self.pickerPhoto))
        miImageViewPicker.addGestureRecognizer(tomaFotoGR)
        
        //TODO: - Configuracion de labels
        configuraLabels()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Utils
    
    func configuraLabels(){
        miLatitud.text = String(format: "%.6f", (detallebarMadrid?.coordinate.latitude)!)
        miLongitud.text = String(format : "%.6f", (detallebarMadrid?.coordinate.longitude)!)
        miDireccion.text = detallebarMadrid?.direccionBares
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

} // TODO: Fin de la clase

extension BMDetalleBarViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        } else {
            muestraLibreriaFotos()
        }
    }

    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil , preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFotoAction = UIAlertAction(title: "Toma foto", style: .default) { _ in
            self.muestraCamara()
        }
        
        let seleccionaLibreria = UIAlertAction(title: "Selecciona de la libreria", style: .default) {
            _ in
            self.muestraLibreriaFotos()
            
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFotoAction)
        alertVC.addAction(seleccionaLibreria)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraCamara(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            miImageViewPicker.image = imageData
            miSalvardatosBTN.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
