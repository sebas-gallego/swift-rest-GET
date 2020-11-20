# Consumo de API REST-GET en iOS Swift

Te presento una App muy simple donde se consume un servicio rest por medio del método GET y se presenta la información obtenida en nuestra vista principal.
- **Nota:**
Este proyecto esta construido con CocoaPods, para mas información ingresar a https://cocoapods.org.
- **Estructura PodFile:**
```swift
# Uncomment the next line to define a global platform for your project
# platform :ios, '8.0'

target 'ExampleRestApi' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!
  
  # Pods for ExampleRestApi
  use_modular_headers!
  pod 'Alamofire', '~> 5.0'
  pod 'AFNetworking', '~> 2.6'
  pod 'ORStackView', '~> 3.0'

end
```
# Pasos

- **HelperNetwork.swift**: Copiar archivo HelperNetwork, el cual contiene el método para consumir el servicio por medio de Alamofire.
```swift
//
//  HelperNetwork.swift
//  ExampleRestApi
//
//  Created by MacBook Pro on 20/11/20.
//

import Foundation
import Alamofire

public var  URL_API = "https://icenparty.pythonanywhere.com/icenPartyWeb/api/v1/"
public var  GET_STORE = "doStore"
public var  METHOD_GET: HTTPMethod = .get

class HelperNetwork{
    
    //Example get json for method GET
    func doRequest(urlString : String,
                   parameters : Parameters,
                   method : HTTPMethod,
                   completion: @escaping (AFDataResponse <Any>)->()) {
        
        let url = URL.init(string: URL_API + urlString)
        AF.request(url!, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in  completion(response)
        }
    }
    
}
```
- **BaseResponse.swift**: Copiar archivo BaseResponse, el cual contiene los modelos correspondientes a la información obtenida en la respuesta del servicio.
```swift
//
//  BaseResponse.swift
//  ExampleRestApi
//
//  Created by MacBook Pro on 20/11/20.
//
/*
 BaseResponse se usa para crear todos los modelos que
 necesitamos para la respuesta del servicio.
 */

import Foundation

public struct Store : Codable{
    var pk: Int
    var fields: Fields
}

public struct Fields : Codable {
    var file_img_home: String
    var file_img_2: String
    var file_img_3: String
    var title: String
    var subTitle: String
    var description: String
    var value: Int
    var material: String
    var color: String
    var sizes_list: String
    var brand: String
}

public struct JSONResponseStore: Codable {
    var success:  Bool
    var message:  String
    var stores :  [Store]
}
``` 
- **ViewController.swift**: En nuestro archivo viewController realizar el llamado de nuestro método doRequest
al cual se le pasan los parámetros necesarios para obtener el json. 

```swift
@IBOutlet weak var lblResponse: UILabel!
var helperNetwork = HelperNetwork()
    
/**
     Get info from server for method GET
     */
    func getJsonRequestGET(){
        
        //Set text lbl
        lblResponse.text = "Consultando información...."
        
        //parameters for get , we need tag typeStore
        let parameters: Parameters = [ "typeStore" : "Hombre",]
        
        self.helperNetwork.doRequest(urlString: GET_STORE,
                                     parameters: parameters,
                                     method: METHOD_GET) { (response) -> () in
            // do stuff with the result
            switch response.result
            {
            case .success( _):
                do {
                    
                    //Decode data From model JSONResponseStore , can be changed to any model
                    let JSONData = try JSONDecoder().decode(JSONResponseStore.self, from: response.data!)
                    
                    if(JSONData.success){
                        self.lblResponse.text = "Respuesta: \(JSONData.stores)"
                    }else{
                        self.lblResponse.text = "Respuesta: \(JSONData.message)"
                    }
                    
                } catch let jsonError {
                    self.lblResponse.text = "Respuesta: \(jsonError)"
                }
                
            case .failure(let error):
                self.lblResponse.text = "Respuesta: \(error)"
            }
        }
        
    }
```
<p align="start">
  <img src="https://icenparty.pythonanywhere.com/media/documents/documents/Captura_de_Pantalla_2020-11-20_a_las_1.35.33_p.m..png" width="350" alt="accessibility text">
</p>

Quedo atento a cualquier inquietud,
Saludos.
