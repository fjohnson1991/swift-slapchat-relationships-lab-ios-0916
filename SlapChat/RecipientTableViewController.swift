//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by Felicity Johnson on 11/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class RecipientTableViewController: UITableViewController {
    
    
    let store = DataStore.sharedInstance
    var recipientArray = [Recipient]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recipientArray = store.recipientArray
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        store.fetchData()
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.recipientArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipient", for: indexPath)

        if let unwrappedName = store.recipientArray[indexPath.row].name {
            cell.textLabel?.text = unwrappedName
        }
        

        return cell
    }
    
    
    @IBAction func addRecipientButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Recipient", message: "Add Recipient", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            
            self.saveRecipient(stringTitle: nameToSave)
            self.tableView.reloadData()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
        func saveRecipient(stringTitle: String) {
            let managedContext = store.persistentContainer.viewContext
            
            let newRecipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: managedContext) as! Recipient
            newRecipient.name = stringTitle
            store.fetchData()
            store.saveContext()
            self.tableView.reloadData()

            
        }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messages" {
            let dest = segue.destination as! TableViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                dest.recipient = store.recipientArray[indexPath.row]
            }
        }
    }
    

}
