//
//  AddViewController.swift
//  TodoList App
//
//  Created by admin on 14/12/2021.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var titleLbl: UITextField!
    @IBOutlet weak var noteLbl: UITextField!
    
    @IBOutlet weak var percentageValue: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var percentageSlider: UISlider!
    
    
    var indexPath: NSIndexPath?
    var t: String?
    var n: String?
    var p: Int?
    var d: String?
    
    
    
    
    weak var delegate: AddTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteLbl.text = n
        titleLbl.text = t
        
        if let perc = p {
            percentageValue.text = "\(p!)%"
            percentageSlider.value = Float(perc)
        }
        else{
            percentageValue.text = "0%"
            percentageSlider.value = 0
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func percentage(_ sender: Any) {
        percentageValue.text = "\(Int(percentageSlider.value))%"
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancel(by: self)
        print("cancel")
    }
    
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.calendar = datePicker.calendar
        formatter.dateFormat = "MM/dd/yyyy"
        
        percentageValue.text = "\(formatter.string(from: sender.date))"
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.calendar = datePicker.calendar
        formatter.dateFormat = "MM/dd/yyyy"
        
        guard let title = titleLbl.text else { return }
        guard let note = noteLbl.text else { return }
        
        
        delegate?.add(by: self, title: title, desc: note, percentage: Int(percentageSlider.value), date: formatter.string(from: datePicker.date), at: indexPath)
    }
    
    
}

