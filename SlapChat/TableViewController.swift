//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance
    var recipient: Recipient!
    var recipientMessages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        recipientMessages = recipient.message?.allObjects as! [Message]
        store.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        recipientMessages = recipient.message?.allObjects as! [Message]
        
        store.fetchData()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipientMessages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        let eachMessage = recipientMessages[indexPath.row]
        
        cell.textLabel?.text = eachMessage.content


        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("add message")
        let destination = segue.destination as! AddMessageViewController
        destination.recipient = recipient
    }
    
}
