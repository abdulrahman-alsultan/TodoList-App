//
//  CustomTableViewCell.swift
//  TodoList App
//
//  Created by admin on 14/12/2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var completed: UILabel!
    
    func setCell(t: String, d: String, n: String){
        title.text = t
        date.text = d
        desc.text = n
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
