//
//  TaskTableViewCell.swift
//  GetItDone
//
//  Created by Srini Motheram on 4/24/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewCell: UITableViewCell {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var cellTask                        :Task!
        
        @IBOutlet var taskNameLabel             :UILabel!
        @IBOutlet var priorityZoneLabel         :UILabel!
        @IBOutlet var taskCompletedLabel   :UILabel!
        
    
        func setCellTask(task: Task) {
            cellTask = task
        }
        
        
    
}
