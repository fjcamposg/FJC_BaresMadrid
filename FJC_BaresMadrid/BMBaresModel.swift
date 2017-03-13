//
//  BMBaresModel.swift
//  FJC_BaresMadrid
//
//  Created by cice on 13/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import MapKit

class BMBaresModel: NSObject {

    var direccionBares : String?
    var latitudBares : Double?
    var longitudBares : Double?
    var imagenBares : String? // url de la imagen -> ruta apple local - remota
    
    init(pDireccionBares: String, pLatitudBares: Double, pLongitudBares: Double, pImagenesBares: String){
        self.direccionBares = pDireccionBares
        self.latitudBares = pLatitudBares
        self.longitudBares = pLongitudBares
        self.imagenBares = pImagenesBares
        super.init()
    }
    
    
    
}


// MARK: -MKAnnotation

extension BMBaresModel : MKAnnotation {

    var coordinate: CLLocationCoordinate2D {
        get {
        return CLLocationCoordinate2D(latitude: latitudBares!, longitude: longitudBares!)
        }
    }
    
    
    var title: String? {
        get {
            return "Bar de Madrid"
        }
    }
    
    var subtitle: String? {
        get {
            return direccionBares?.replacingOccurrences(of: "\n", with: "")
        }
    }
    
}
