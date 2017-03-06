//
//  BMNoticiaCustomCell.swift
//  FJC_BaresMadrid
//
//  Created by cice on 6/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class BMNoticiaCustomCell: UITableViewCell {

    //MARK: -IBOUtlets
    
    
    @IBOutlet weak var miImagenNoticia: UIImageView!
    
    @IBOutlet weak var miTituloNoticia: UILabel!
    
    @IBOutlet weak var miThumbnailNoticia: UIImageView!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
