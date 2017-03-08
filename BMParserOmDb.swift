//
//  BMParserOmDb.swift
//  FJC_BaresMadrid
//
//  Created by cice on 8/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire


class BMParserOmDb: NSObject {
    var jsonDataOmDb : JSON?
    /// Crea la funcion de obtencion de datos Ombd y contiene un parametro de entrada
    ///
    /// - parameter idNumero: El idNumero corresponde al numero que puede variar entre 1 y 30
    /// - returns: La promise de un JSON -> implememta pods de PromiseKit / Alamofire / SwiftyJSON
    
    func getDatosOmDb(_ idNumero : String) -> Promise<JSON>{
        let request = URLRequest(url: URL(string: CONSTANTES.CONEXIONES_URL.BASE_URL_OMDB  + idNumero)!)
        return Alamofire.request(request).responseJSON().then{(data)->JSON in
            self.jsonDataOmDb = JSON(data)
            print(self.jsonDataOmDb!)
            return self.jsonDataOmDb!
        }
    }
    
    func getPaserOmDb() -> [BMlmdbModel]{
        var arrayDatosOmdb = [BMlmdbModel]()
        for item in jsonDataOmDb!["Search"]{
            let datosModel = BMlmdbModel(pTitle: dimeString(item.1, nombre: "Title"),
                                         pYear: dimeString(item.1, nombre: "Year"),
                                         pImdbID: dimeString(item.1, nombre: "imdbID"),
                                         pType: dimeString(item.1, nombre: "Type"),
                                         pPoster: dimeString(item.1, nombre: "Poster"))
            arrayDatosOmdb.append(datosModel)
        }
        return arrayDatosOmdb
    }
}

