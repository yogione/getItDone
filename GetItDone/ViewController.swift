//
//  ViewController.swift
//  GetItDone
//
//  Created by Srini Motheram on 1/30/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext :NSManagedObjectContext!
    
    var taskArray = [Task]()
    @IBOutlet var taskTableView :UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEdit" {
            let indexPath = taskTableView.indexPathForSelectedRow!
            let currentTask = taskArray[indexPath.row]
            let destVC = segue.destination as! DetailViewController
            destVC.currentTask = currentTask
            taskTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //MARK :- TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskTableViewCell
        let currentTask = taskArray[indexPath.row]
        cell.setCellTask(task: currentTask)
        cell.taskNameLabel.text =  currentTask.taskName
        cell.taskCompletedLabel.text = currentTask.taskCompleted
        cell.priorityZoneLabel.text = currentTask.priorityZone
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactToDelete = taskArray[indexPath.row]
            managedContext.delete(contactToDelete)
            appDelegate.saveContext()
            taskArray = appDelegate.fetchAllTasks()
            taskTableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.isEditing = false
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    // life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        managedContext = appDelegate.persistentContainer.viewContext
        taskTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskArray = appDelegate.fetchAllTasks()
        print("Count: \(taskArray.count)")
        taskTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

