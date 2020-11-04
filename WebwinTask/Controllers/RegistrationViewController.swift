//
//  RegistrationViewController.swift
//  WebwinTask
//
//  Created by Bharat on 03/11/20.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var userEmailIdTxtField: UITextField!
    @IBOutlet weak var enterPasswrdTxtField: UITextField!
    @IBOutlet weak var reEntrPasswrdTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func RegisterAction(_ sender: UIButton) {
        
        if userEmailIdTxtField.text != "" {
            
            if emailValidation(userEmailIdTxtField.text!){
                
                if enterPasswrdTxtField.text != "" {
                    
                    if reEntrPasswrdTxtField.text != "" {
                        
                        if enterPasswrdTxtField.text == reEntrPasswrdTxtField.text {
                            
                            print("Registered")
                            
                            let loginVc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                            loginVc.registeredUserId = userEmailIdTxtField.text!
                            loginVc.userPassword = enterPasswrdTxtField.text!
                            self.present(loginVc, animated: false, completion: nil)
                            
                            
                        }else{
                            alertcontroller(title: "Oops", message: "Passowrd Mismatch")
                        }
                        
                    }else {
                        alertcontroller(title: "Oops", message: "Please Enter Re enter password")
                    }
                }else {
                    alertcontroller(title: "Oops", message: "Please Enter Password")
                }
            }else {
                alertcontroller(title: "Oops", message: "Please Enter valid Email Id")
            }
        } else {
            alertcontroller(title: "Oops", message: "Please enter Email Id")
        }
        
    }
    
    
    
}
