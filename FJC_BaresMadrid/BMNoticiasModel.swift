//
//  BMNoticiasModel.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class BMNoticiasModel: NSObject {
    var albumId : Int?
    var id : Int?
    var title : String?
    var url : String?
    var thumbnailUrl : String?
    
    init(pAlbumId : Int, pId : Int, pTitle : String, pUrl : String, pThumbnailUrl : String) {
        self.albumId = pAlbumId
        self.id = pId
        self.title = pTitle
        self.url = pUrl
        self.thumbnailUrl = pThumbnailUrl
        super.init()
    }

}
