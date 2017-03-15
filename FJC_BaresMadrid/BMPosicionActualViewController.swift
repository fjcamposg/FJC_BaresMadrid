//
//  BMPosicionActualViewController.swift
//  FJC_BaresMadrid
//
//  Created by cice on 22/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BMPosicionActualViewController: UIViewController {

    //MARK: -vbles. locales
    var baresMadrid : BMBaresModel?
    let locationManager = CLLocationManager()
    var calloutImagenSeleccionada : UIImage?
    
    var actualizandoLocalizacion = false {
        didSet{
            if actualizandoLocalizacion{
                self.buscarmapa.setImage(#imageLiteral(resourceName: "btn_localizar_off"), for: .normal)
                self.miActivityIndicator.isHidden = false
                self.miActivityIndicator.startAnimating()
                self.buscarmapa.isUserInteractionEnabled = false
            }else{
                self.buscarmapa.setImage(#imageLiteral(resourceName: "btn_localizar_on"), for: .normal)
                self.miActivityIndicator.isHidden = true
                self.miActivityIndicator.stopAnimating()
                self.buscarmapa.isUserInteractionEnabled = true
                self.miAddBoton.isEnabled = false
            }
        }
    }
    
    
      //MARK: - IBoutlets
    @IBOutlet weak var buscarmapa: UIButton!
    @IBOutlet weak var menuButtom: UIBarButtonItem!
    @IBOutlet weak var miMapView: MKMapView!
    @IBOutlet weak var miActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var miAddBoton: UIBarButtonItem!
    
    //MARK: - IBActions
    
    @IBAction func ontenerLocalizacion(_ sender: Any) {
        iniciaLocationManager()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
        
        
        // Fase 1 -> SINGLETON
        APIManagerData.shared.cargarDatos()
        
        
        
        
        actualizandoLocalizacion = false
        
        //TODO: - Titulo de la barra de navegacion
        let imageNavBarTitle = #imageLiteral(resourceName: "img_navbar_title")
        self.navigationItem.titleView = UIImageView(image: imageNavBarTitle)
        
        
        
        //TODO: - Gestion de statusBar
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        //TODO: - Gestion del menu superior
        if revealViewController() != nil {
            menuButtom.target = revealViewController()
            menuButtom.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        miMapView.delegate = self
        miMapView.addAnnotations(APIManagerData.shared.baresMadrid)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Uils
    
    func iniciaLocationManager(){
        let estadoAutorizado = CLLocationManager.authorizationStatus()
        switch estadoAutorizado {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            present(muestraAlertVC("Localizacion desactivada", messageData: "Por favor, ajusta la localizacion  en el dispositivo", titleActionData: "OK"), animated: true, completion: nil)
                self.miAddBoton.isEnabled = false
        default:
            if CLLocationManager.locationServicesEnabled(){
                self.actualizandoLocalizacion = true
                self.miAddBoton.isEnabled = false
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestLocation()
                
                let region = MKCoordinateRegionMakeWithDistance(miMapView.userLocation.coordinate, 100,100)
                miMapView.setRegion(miMapView.regionThatFits(region), animated: true)
                
            }
        }
    }
    
    // MARK: - SEGUES
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagBaresMadrid" {
            let navController = segue.destination as! UINavigationController
            let detalleVC = navController.topViewController as! BMDetalleBarViewController
            detalleVC.detallebarMadrid = baresMadrid
            detalleVC.bmDelegate = self
            
            
            
        }
        if segue.identifier == "showPinImage"{
            let navVC = segue.destination as! UINavigationController
            let detalleImVC = navVC.topViewController as! BMImagenViewController
            detalleImVC.calloutIm = calloutImagenSeleccionada
            
        }
    }

}


extension BMPosicionActualViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last{
            let latitud = userLocation.coordinate.latitude
            let longitud = userLocation.coordinate.longitude
            
            
            //TODO: - CLgeocoder -> Api de los mapas
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) in
                if error == nil{
                    var direccion = ""
                    if let placemarksData = placemarks?.last{
                        direccion = self.stringFromPlacemarks(placemarksData)
                    }
                    self.baresMadrid = BMBaresModel(pDireccionBares: direccion, pLatitudBares: latitud, pLongitudBares: longitud, pImagenesBares: "")
                    
                }
                self.actualizandoLocalizacion = false
                self.miAddBoton.isEnabled = true
                
            })
        }
    }
    
    

    
    func stringFromPlacemarks(_ placemarkData : CLPlacemark) -> String{
        var lineaUno = ""
        if let stringUno = placemarkData.thoroughfare {
            lineaUno += stringUno + " "
        }
        if let stringUno = placemarkData.subThoroughfare {
            lineaUno += stringUno
        }
        
        
        var lineaDos = ""
        if let stringDos = placemarkData.postalCode {
            lineaDos += stringDos + " "
        }
        if let stringDos = placemarkData.locality {
            lineaDos += stringDos
        }
        
        var lineaTres = ""
        if let stringTres = placemarkData.administrativeArea {
            lineaTres += stringTres + " "
        }
        if let stringTres = placemarkData.locality {
            lineaTres += stringTres
        }
        
        return lineaUno + "\n" + lineaDos + "\n" +  lineaTres
    }
}

extension BMPosicionActualViewController : BMDetalleBarViewControllerDelegate {
    func bmBaresEtiquetados(_ detalleVC: BMDetalleBarViewController, barEtiquetado: BMBaresModel) {
        // FASE 2 Singleton
        APIManagerData.shared.baresMadrid.append(barEtiquetado)
        APIManagerData.shared.salvarDatos()
        
    }
}

// MARK: -MKMAPVIEWDELEGATE
extension BMPosicionActualViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        // como en las celdas de las tablas, se reaprovecha las veces necearias
        var annotationView = miMapView.dequeueReusableAnnotationView(withIdentifier: "barpin")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "barpin")
        } else {
            annotationView?.annotation = annotation
        }
        
        //3 Vamos a configurar la anotacion
        if let place = annotation as? BMBaresModel{
            //hacemos referencia a las piezas del objeto
            let imageName = place.imagenBares
            //comprobamos imagen
            if let imagenUrl = APIManagerData.shared.imagenesUrl(){
                do{
                    let imageData = try Data(contentsOf: imagenUrl.appendingPathComponent(imageName!))
                    self.calloutImagenSeleccionada = UIImage(data: imageData)
                    let myImageFromDDBB = resizeImage(calloutImagenSeleccionada!, newWidth: 40.0)
                    let btnImageView = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    btnImageView.setImage(myImageFromDDBB, for: .normal)
                    annotationView?.leftCalloutAccessoryView = btnImageView
                    annotationView?.image = #imageLiteral(resourceName: "img_pin")
                    annotationView?.canShowCallout = true
                }catch let error{
                    print ("Error en la configuracion de la imagen \(error.localizedDescription)")
                }
            }
        }
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView{
            performSegue(withIdentifier: "showPinImage", sender: view)
            
        }
    }
    
    
    //MARK: - Util
    
    func resizeImage(_ imagen : UIImage, newWidth : CGFloat) -> UIImage{
        let scale = newWidth / imagen.size.width
        let newHeight = imagen.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        imagen.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
