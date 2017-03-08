//
//  BMParserNoticias.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class BMParserNoticias: NSObject {
    var jsonDataNoticias : JSON?
    
    func getDatosNoticias() -> Promise<JSON>{
        let request = NSMutableURLRequest(url: URL(string: CONSTANTES.CONEXIONES_URL.BASE_URL_NOTICIAS)!)
        return Alamofire.request(request as URLRequest).responseJSON().then{(data)->JSON in
            self.jsonDataNoticias = JSON(data)
            print(self.jsonDataNoticias!)
            return self.jsonDataNoticias!
            
            }
    
    }

    func getParserNoticias() -> [BMNoticiasModel]{
        var arrayNoticiasModel = [BMNoticiasModel]()
        for item in jsonDataNoticias!{
            let noticiasModel = BMNoticiasModel(pAlbumId: dimeInt(item.1, nombre: "albumId"),
                                                pId: dimeInt(item.1, nombre: "id"),
                                                pTitle: dimeString(item.1, nombre: "title"),
                                                pUrl: dimeString(item.1, nombre: "url"),
                                                pThumbnailUrl: dimeString(item.1, nombre: "thumbnailUrl"))
            arrayNoticiasModel.append(noticiasModel)
        }
        return arrayNoticiasModel
    }
    
}
