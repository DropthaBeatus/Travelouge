//
//  EntriesTableViewController.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {

    var trips : Trips?
    
    @IBOutlet var entryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Trips"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (trips?.travelouges?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        if let cell = cell as? EntriesTableViewCell {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            let document = trips?.travelouges?[indexPath.row]
            cell.nameLabel.text = document?.title
            
            if let date = document?.date{
                cell.dateLabel.text = dateformatter.string(from : date)
            } else{
                cell.dateLabel.text = "Date was not found"
            }
            
            /*
            if let modifiedDate = document?.modifiedDate {
                cell.DocDate.text = dateFormatter.string(from: modifiedDate)
            } else {
                cell.DocDate.text = "unknown"
            }
            */
        }
        
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LogViewController else{
            return
        }
        //gonna hafta delete travelouge most likely
        destination.trips = trips
    }
 /*
    @IBAction func Create(_ sender: Any) {
        performSegue(withIdentifier: "Push2", sender: self)
    }
    
*/    override func viewWillAppear(_ animated: Bool){
        self.entryTableView.reloadData()
        
    }
    
    func deleteDoc(at indexPath: IndexPath){
        guard let entry = trips?.travelouges![indexPath.row],let managedContext = entry.managedObjectContext else{
            return
        }
        managedContext.delete(entry)
        
        do{
            try managedContext.save()
            
            entryTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch{
            print("Can't delete")
            
            entryTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteDoc(at: indexPath)
        }
    }


}
