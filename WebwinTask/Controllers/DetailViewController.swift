//
//  DetailViewController.swift
//  WebwinTask
//
//  Created by Bharat on 04/11/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var fsrtName_: UILabel!
    @IBOutlet weak var lastName_: UILabel!
    @IBOutlet weak var country_: UILabel!
    @IBOutlet weak var age_: UILabel!
    @IBOutlet weak var address_: UILabel!
    
    var users : Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let users = users else {
            return
        }
        
        self.fsrtName_.text = users.firstName
        self.lastName_.text = users.lastName
        self.country_.text = users.country
        self.age_.text = users.age
        self.address_.text = users.address
        
        self.image.image = UIImage(data: users.userImage!)


        
    }
    

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
