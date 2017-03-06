//
//  BMlmdbModel.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class BMlmdbModel: NSObject {

    var title : String?
    var year : String?
    var imdbID: String?
    var type : String?
    var poster: String?
    
    init(pTitle: String, pYear: String, pImdbID: String, pType: String, pPoster : String) {
        self.title = pTitle
        self.year = pYear
        self.imdbID = pImdbID
        self.type = pType
        self.poster = pPoster
        super.init()
    }
    
}
