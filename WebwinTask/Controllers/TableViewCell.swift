//
//  TableViewCell.swift
//  WebwinTask
//
//  Created by Bharat on 04/11/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userImge: UIImageView!
    @IBOutlet weak var frstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
