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
    var travelouges = [Travelouge]()
    
    @IBOutlet var entryTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = trips?.destination ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTravelouge()
        entryTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return travelouges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        if let cell = cell as? EntriesTableViewCell {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            let log = travelouges[indexPath.row]
            cell.nameLabel.text = log.title
            cell.entryImage.image = log.pic
            if let date = log.date{
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
        if let destination = segue.destination as? LogViewController,
            let segueIdentifier = segue.identifier {
                destination.trips = trips
                if (segueIdentifier == "Push2Info") {
                    if let row = entryTableView.indexPathForSelectedRow?.row {
                        destination.travelouge = travelouges[row]
                    }
                }
        }
        
    }

    func deleteDoc(at indexPath: IndexPath){
        guard let entry = trips?.travelouges![indexPath.row],let managedContext = entry.managedObjectContext else{
            return
        }
        managedContext.delete(entry)
        
        do{
            try managedContext.save()
            self.travelouges.remove(at: indexPath.row)
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
    
    func updateTravelouge(){
        travelouges = trips?.travelouges ?? [Travelouge]()
    }


}
