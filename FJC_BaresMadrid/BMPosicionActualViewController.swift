//
//  BMPosicionActualViewController.swift
//  FJC_BaresMadrid
//
//  Created by cice on 22/2/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class BMPosicionActualViewController: UIViewController {

    //MARK: -vbles. locales
    
    
    
    //MARK: - IBoutlets
    
    @IBOutlet weak var menuButtom: UIBarButtonItem!
    

    
    //MARK: - IBActions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gestion del menu

        if revealViewController() != nil {
            menuButtom.target = revealViewController()
            menuButtom.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

