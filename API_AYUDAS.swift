//
//  API_AYUDAS.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import SwiftyJSON

func muestraAlertVC(_ titleData : String, messageData: String, titleActionData: String)->UIAlertController{
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: titleActionData, style: .default, handler: nil))
    return alert
}

func dimeString(_ json : JSON, nombre : String) ->String {
    if let stringResult = json[nombre].string{
        return stringResult
    } else {
        return ""
    }
}

//Descripcion: parametro JSON que viene de la promise de un JSON, variable local en cada parser
//@nombre: Como la definicion de la clave del JSON

func dimeInt(_ json : JSON, nombre : String) ->Int {
    if let intResult = json[nombre].int{
        return intResult
    } else {
        return 0
    }
}

func dimeDouble(_ json : JSON, nombre : String) ->Double {
    if let doubleResult = json[nombre].double{
        return doubleResult
    } else {
        return 0.0
    }
}

func dimeFloat(_ json : JSON, nombre : String) ->Float {
    if let floatResult = json[nombre].float{
        return floatResult
    } else {
        return 0.0
    }
}
