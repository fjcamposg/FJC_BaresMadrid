//: Playground - noun: a place where people can play

import Foundation

// Segundo metod de persistencia con el protocolo NSCoding

class Persona : NSObject, NSCoding {
    var nombre : String!
    var apellido : String!
    var direccion : String!
    var email : String!
    var wifi : String!
    var edad : String!
    var movil : String!
    
    init(pNombre : String, pApellido : String, pDireccion : String, pEmail : String, pWifi : String, pEdad : String, pMovil : String){
        self.nombre = pNombre
        self.apellido = pApellido
        self.direccion = pDireccion
        self.email = pEmail
        self.wifi = pWifi
        self.edad = pEdad
        self.movil = pMovil
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let nombreDe = aDecoder.decodeObject(forKey: "nombreKey") as! String
        let apellidoDe = aDecoder.decodeObject(forKey: "apellidoKey") as! String
        let direccionDe = aDecoder.decodeObject(forKey: "direccionKey") as! String
        let emailDe = aDecoder.decodeObject(forKey: "emailKey") as! String
        let wifiDe = aDecoder.decodeObject(forKey: "wifiKey") as! String
        let edadDe = aDecoder.decodeObject(forKey: "edadKey") as! String
        let movilDe = aDecoder.decodeObject(forKey: "movilKey") as! String
        
        self.init(pNombre : nombreDe, pApellido : apellidoDe, pDireccion : direccionDe, pEmail : emailDe, pWifi : wifiDe, pEdad : edadDe, pMovil : movilDe)
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nombre, forKey: "nombreKey")
        aCoder.encode(self.apellido, forKey: "apellidoKey")
        aCoder.encode(self.direccion, forKey: "direccionKey")
        aCoder.encode(self.email, forKey: "emailKey")
        aCoder.encode(self.wifi, forKey: "wifiKey")
        aCoder.encode(self.edad, forKey: "edadKey")
        aCoder.encode(self.movil, forKey: "movilKey")
    }
}

var multitud = [Persona]()

multitud.append(Persona(pNombre: "Javier", pApellido: "Campos", pDireccion: "Povedilla", pEmail: "aa@aaaa.com", pWifi: "asasasasasad1233", pEdad: "36", pMovil: "666 666 666"))

multitud.append(Persona(pNombre: "Antonio", pApellido: "Garcia", pDireccion: "Puerta del Sol", pEmail: "bbbb@eee.com", pWifi: "2323232Sa", pEdad: "40", pMovil: "999 999 9999"))

multitud.append(Persona(pNombre: "AAAAA", pApellido: "BBBBBB", pDireccion: "CCCCCC", pEmail: "DDDDDD", pWifi: "342342342342", pEdad: "33", pMovil: "1111 111 11"))

// Este array de multitud se puede comvertir en un objeto seriaizable, tenemos que tener una ruta del fichero en la que vamos a peristir esta informacion
//url? puede o no existir esa ruta

func dataBaseUrl() -> URL?{
    if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
        let customUrl = URL(fileURLWithPath: documentDirectory)
        print(customUrl)
        return customUrl.appendingPathComponent("multitud.data")
    } else {
        return nil
    }
    
}


func salvarInfo(){
    // Si tengo una url guardada en databaseURL?
    // archivo con la propiedad path la rura del fichero
    
    if let urlData = dataBaseUrl(){
        NSKeyedArchiver.archiveRootObject(multitud, toFile: urlData.path)
        print(urlData.path)
    } else {
        print("Error guardando datos")
    }
}


func cargarDatos(){
    if let urlData = dataBaseUrl() {
        if let datosSalvados = NSKeyedUnarchiver.unarchiveObject(withFile: urlData.path) as? [Persona] {
            multitud = datosSalvados
        }else {
            print ("Error leyendo datos")
        }
    }
}


//1

salvarInfo()

//2

multitud.removeAll()

//3

cargarDatos()

for c_persona in multitud{
    print("Nombre: \(c_persona.nombre!) \n Apellido: \(c_persona.apellido!)")
}



