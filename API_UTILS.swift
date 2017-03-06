//
//  API_UTILS.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

struct Constantes {
    let COLORES = Colores()
    let CONEXIONES_URL = Baseurl()
    
}

struct Colores {
    let AZUL_BARRA_NAV = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8352941176, alpha: 1)
    let BLANCO_TEXTO_BARRA_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
}

struct Baseurl{
    let BASE_URL_NOTICIAS = "https://jsonplaceholder.typicode.com/photos"
    let BASE_URL_IMDB = ""
}
