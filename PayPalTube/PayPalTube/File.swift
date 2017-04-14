//
//  ViewController.swift
//  PayPalTube
//
//  Created by Udit Pandoh on 14/04/17.
//  Copyright © 2017 UditPandoh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
var dData : [Data] = []
class ViewController2: UIViewController {
    
    
    
    @IBAction func download(_ sender: Any) {
        
        
        let parameters = ["page_Id": "2", "active": "false","amount":"200"]
        
        Alamofire.request("http://localhost:3000/api/posts", method: .get)//, parameters: parameters)
            .responseJSON{ response in
              //  print(response)
                if let result = response.result.value{
                    
                    let userData = JSON(result)
                    //  s//elf.StoreData(userData: userData)
                    //let defaults = UserDefaults.standard
                    //let firstName = userData["name"].string
                  //  print(userData)
                    
                    for item in userData
                    {
                     
                        
                        print(item)
                        
                        
                       let pussy = Data.init(uniqueId: String(describing: item.1["_id"]), active: String(describing: item.1["active"]), created_at: String(describing: item.1["created_at"]), pageId: String(describing: item.1["key"]), amount: String(describing: item.1["amount"]))
                        dData.append(pussy)
                    }
                    
                 
                    // self.greetingsLabel.text = "Hey " + firstName! + "! What's up?"
                }
        }
        
    }
    
    @IBAction func show(_ sender: Any) {
        for items in dData
        {
            print(items.uniqueId)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
}

