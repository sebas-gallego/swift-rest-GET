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

- **BaseResponse.swift**: Copiar archivo BaseResponse, el cual contiene los modelos correspondientes a la información obtenida en la respuesta del servicio.

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
Saludos
