//
//  BMPosterCustomCell.swift
//  FJC_BaresMadrid
//
//  Created by cice on 8/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class BMPosterCustomCell: UITableViewCell {

    
    
    @IBOutlet weak var miImagenPoster: UIImageView!
    
    @IBOutlet weak var miTitulo: UILabel!
    
    
    @IBOutlet weak var miYear: UILabel!
    
    
    @IBOutlet weak var miId: UILabel!
    
    @IBOutlet weak var miTipo: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
