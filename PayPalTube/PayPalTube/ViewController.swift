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
class ViewController: UIViewController, PayPalPaymentDelegate {
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    var shortDes = "yo"
    var last4 = " "
    var totall : NSDecimalNumber = 100.00
     var item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 2, withPrice: NSDecimalNumber(string: "84.99"), withCurrency: "USD", withSku: "Hip-0037")
    var payPalConfig = PayPalConfiguration() // default
    var resultText = "" // empty
    
   // var  frameZ = CGRect(x: 0, y: 0, width: 0, height: 0)
    var sampleTextField = UITextField(frame:  CGRect(x: 0, y: 0, width: 0, height: 0))
    let vieww = UIView(frame:  CGRect(x: 0, y: 0, width: 0, height: 0))
    var  textField = UILabel(frame:  CGRect(x: 60, y: 50, width: 400, height: 200))
    // UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    var page_id = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(productName : "hey")
        item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 2, withPrice: NSDecimalNumber(string: "800.99"), withCurrency: "USD", withSku: "Hip-0037")
        // Do any additional setup after loading the view, typically from a nib.
        
    
  
  
     
        
        
        
        
        
        
}
    
    func setup(productName: String)
    {
        
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = productName
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .both;
        
        
        
        ///////////////////////////////////////////////
        // Do any additional setup after loading the view, typically from a nib.
        let frame = CGRect(x: view.center.x - view.frame.width/1.5, y: 0, width: view.frame.width - 100, height: view.frame.height/1.2 - 20)
        
        vieww.frame = frame
        vieww.center = view.center
        let frameB = CGRect(x: 200 , y: vieww.center.y - vieww.frame.height/16, width: vieww.frame.width/2 + 50, height: vieww.frame.height/8 - 30)
        
        vieww.backgroundColor = UIColor.init(red: 40/255, green: 155/255, blue: 204/255, alpha: 1)
        view.tintColor = UIColor.gray
        
        vieww.layer.cornerRadius = 10
         view.addSubview(vieww)
        vieww.alpha = 0
        let myFirstButton = UIButton()
        myFirstButton.backgroundColor = UIColor.init(red: 40/255, green: 171/255, blue: 226/255, alpha: 1)
        myFirstButton.setTitle("Submit", for: .normal)
        myFirstButton.setTitleColor(UIColor.white, for: .normal)
        myFirstButton.frame = frameB
        myFirstButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        myFirstButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        // self.view.addSubview(myFirstLabel)
        myFirstButton.center.x = vieww.center.x - 50
        myFirstButton.center.y = vieww.center.y/2 + 120
        self.vieww.addSubview(myFirstButton)
        
        let myFirstButton2 = UIButton()
        myFirstButton2.backgroundColor = UIColor.init(red: 40/255, green: 171/255, blue: 226/255, alpha: 1)
        myFirstButton2.setTitle("Pay Now", for: .normal)
        myFirstButton2.setTitleColor(UIColor.white, for: .normal)
        myFirstButton2.frame = frameB
        var frameC = CGRect(x: vieww.center.x - vieww.frame.width/4, y: vieww.center.y - vieww.frame.height/16 - 20 + frameB.height + 10, width: vieww.frame.width/2 + 50, height: vieww.frame.height/8 - 30)
        myFirstButton2.frame = frameC
        
        myFirstButton2.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 19)
        myFirstButton2.addTarget(self, action:#selector(self.buttonClicked2), for: .touchUpInside)
        // self.view.addSubview(myFirstLabel)
        myFirstButton2.center.x = vieww.center.x - 50
        myFirstButton2.center.y = vieww.center.y/2 + myFirstButton.frame.height + 130
        self.vieww.addSubview(myFirstButton2)
        
        
        var frameD = CGRect(x: 200, y: vieww.center.y - vieww.frame.height/16 - frameC.height - 30 , width: vieww.frame.width/2 + 90 , height: vieww.frame.height/8 - 20  )
        sampleTextField.frame =  frameD
        sampleTextField.placeholder = ""
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextBorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        sampleTextField.center.x = vieww.center.x/2 + 45
        sampleTextField.center.y = vieww.center.y/2 + 50
        self.vieww.addSubview(sampleTextField)
        
        
        //
        
       
       
        textField.font = UIFont.systemFont(ofSize: 35)
        textField.text = "Enter Token "
        textField.textColor = UIColor.white
        vieww.addSubview(textField)
        
        //
        
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
       
        //vieww.alpha = 0
        UIView.animate(withDuration: 1) {
         self.vieww.alpha = 1
        }
        

    }

    
    func buttonClicked() {
        for item in dData {
           var a = item.uniqueId.substring(from:item.uniqueId.index(item.uniqueId.endIndex, offsetBy: -4))
           if    sampleTextField.text ==  a
           {
            print("match")
            vieww.removeFromSuperview()
            
            
            
            }
        else
           {
            print("non match")
            }
            
        }
        
    }
    
    func buttonClicked2() {
        resultText = ""
        
        // Note: For purposes of illustration, this example shows a payment that includes
        //       both payment details (subtotal, shipping, tax) and multiple items.
        //       You would only specify these if appropriate to your situation.
        //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
        //       and simply set payment.amount to your total charge.
        
        // Optional: include multiple items
        
       
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "5.99")
        let tax = NSDecimalNumber(string: "2.50")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: shortDes, intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }

    }
    
    ////////////////////////
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func payAction(_ sender: Any) {
        var alertView = UIAlertView();
        alertView.addButton(withTitle: "Ok");
        alertView.title = "Your Token";
        alertView.message = "ougho";
        alertView.show()
               }
    
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        
        
        
        
        
        
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
             let parameters = ["page_Id": String(self.page_id), "active": "false","amount":String(describing: self.totall)]
            Alamofire.request("http://localhost:3000/api/posts", method: .post, parameters: parameters)
                .responseJSON{ response in
                    //  print(response)
                    if let result = response.result.value{
                        
                        let userData = JSON(result)
                        //  s//elf.StoreData(userData: userData)
                        //let defaults = UserDefaults.standard
                        //let firstName = userData["name"].string
                        //  print(userData)
                        print("///////////////////////////////////")
                        var a =  String(describing: userData["_id"])
                        self.last4 = a.substring(from:a.index(a.endIndex, offsetBy: -4))
                        print(self.last4)
                         print("///////////////////////////////////")
                        
                        var alertView = UIAlertView();
                        alertView.addButton(withTitle: "Ok");
                        alertView.title = "Your Token";
                        alertView.message = self.last4;
                        self.sampleTextField.text = self.last4
                        alertView.show()
                        
                        
                        
                        // self.greetingsLabel.text = "Hey " + firstName! + "! What's up?"
                    }
            }
            
            Alamofire.request("http://localhost:3000/api/posts", method: .get)//, parameters: parameters)
                .responseJSON{ response in
                    //  print(response)
                    if let result = response.result.value{
                        
                        let userData = JSON(result)
                        //  s//elf.StoreData(userData: userData)
                        //let defaults = UserDefaults.standard
                        //let firstName = userData["name"].string
                        //  print(userData)
                        dData.removeAll()
                        for item in userData
                        {
                            
                            
                            print(item)
                            
                            
                            let pussy = Data.init(uniqueId: String(describing: item.1["_id"]), active: String(describing: item.1["active"]), created_at: String(describing: item.1["created_at"]), pageId: String(describing: item.1["key"]), amount: String(describing: item.1["amount"]))
                            dData.append(pussy)
                        }
                        
                        
                        // self.greetingsLabel.text = "Hey " + firstName! + "! What's up?"
                    }
            }
            
            
            //
            
            //
            
        })
    }

}

