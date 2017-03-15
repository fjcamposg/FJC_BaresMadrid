//
//  APIManagerData.swift
//  FJC_BaresMadrid
//
//  Created by cice on 15/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit

class APIManagerData: NSObject {
    
    //SINGLETON
    static let shared = APIManagerData()
    var baresMadrid : [BMBaresModel] = []
    
    //MARK: - Salvar datos
    func salvarDatos(){
        //URL en donde se va a guardar nuestro archivo existe??
        if let url = dataBaseUrl(){
            NSKeyedArchiver.archiveRootObject(baresMadrid, toFile: url.path)
        } else {
            print ("Error guardando datos")
        }
    
    }
    
    //MARK: -Cargar datos
    func cargarDatos(){
        if let customUrl = dataBaseUrl(), let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: customUrl.path) as? [BMBaresModel]{
            baresMadrid = datosSalvados
        } else {
            print("Error cargando datos")
        }
    }
    
    //MARK: - URL Imagen
    func imagenesUrl() -> URL? {
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let customurl = URL(fileURLWithPath: documentDirectory)
            return customurl
        } else {
            return nil
        }
    }
    
    
    //MARK:- URL
    func dataBaseUrl() -> URL?{
        if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
            let customurl = URL(fileURLWithPath: documentDirectory)
            return customurl.appendingPathComponent("baresMadrid.data")
        } else {
            return nil
        }
    }
    
    
    
    
    
    
    
    
    

}
