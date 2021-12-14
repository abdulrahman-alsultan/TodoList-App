//
//  AddTaskDelegate.swift
//  TodoList App
//
//  Created by admin on 14/12/2021.
//

import UIKit


protocol AddTaskDelegate: AnyObject{
    func add(by controller: AddViewController, title: String, desc: String, percentage: Int, date: String, at indecPath: NSIndexPath?)
    
    func cancel(by controller: AddViewController)
}
