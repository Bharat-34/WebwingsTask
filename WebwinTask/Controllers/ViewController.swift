//
//  ViewController.swift
//  WebwinTask
//
//  Created by Bharat on 03/11/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [Users] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        getData()
        self.tableView.reloadData()
    }
    
    
    @IBAction func goToRegistration(_ sender: UIButton) {
        
        let RegVc = self.storyboard?.instantiateViewController(identifier: "RegistrationViewController") as! RegistrationViewController
        self.present(RegVc, animated: false, completion: nil)
    }
    
  

}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let user = users[indexPath.row]
        
        Cell.frstName.text = user.firstName
        Cell.lastName.text = user.lastName
        Cell.age.text = user.age
        Cell.country.text = user.country
        Cell.address.text = user.address
        Cell.userImge.image = UIImage(data: user.userImage!)
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension

    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    func getData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            users = try context.fetch(Users.fetchRequest())
        }
        catch{
            print("Fetching failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            let user = users[indexPath.row]
            context.delete(user)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                users = try context.fetch(Users.fetchRequest())
            }
            catch{
                print("Fetching Failed")
            }
        }
        
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nxtVc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        nxtVc.users = users[indexPath.row]
        self.present(nxtVc, animated: false, completion: nil)
    }
    
    
    
}
