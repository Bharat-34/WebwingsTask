//
//  LoginViewController.swift
//  WebwinTask
//
//  Created by Bharat on 03/11/20.
//

import UIKit

class LoginViewController: UIViewController {

    var registeredUserId = String()
    var userPassword = String()
    
    @IBOutlet weak var loginIdTxtField: UITextField!
    @IBOutlet weak var loginPasswrdTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if loginIdTxtField.text != "" {
            
            if emailValidation(loginIdTxtField.text!){
                
                if loginPasswrdTxtField.text != "" {
                    
                    if loginIdTxtField.text == registeredUserId && loginPasswrdTxtField.text == userPassword {
                        
                        let profileVc = self.storyboard?.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
                        self.present(profileVc, animated: false, completion: nil)
                        
                    }else {
                        alertcontroller(title: "Login Failed", message: "Please enter registered Mail Id")
                    }
                    
                }else{
                    alertcontroller(title: "Oops", message: "Please enter Password")
                }
                
            }else{
                alertcontroller(title: "Oops", message: "Please enter valid Mail Id")
            }
            
        }else{
            alertcontroller(title: "Oops", message: "Please Enter LoginId")
        }
        
    }
    
    
    

   

}
