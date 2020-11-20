//
//  ViewController.swift
//  ExampleRestApi
//
//  Created by MacBook Pro on 19/11/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var lblResponse: UILabel!
    var helperNetwork = HelperNetwork()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //load memory
    override func  loadView() {
        super.loadView()
        print("loadView")
    }
    
    //load view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    //load view finish
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("viewDidDisappear")
    }
    
    @IBAction func getJson(_ sender: UIButton) {
        getJsonRequestGET()
    }
    
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
    
}

