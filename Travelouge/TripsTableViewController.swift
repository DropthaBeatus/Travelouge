//
//  TripsTableViewController.swift
//  Travelouge
//
//  Created by Liam Flaherty on 12/2/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit
import CoreData

class TripsTableViewController: UITableViewController {

    var trips : [Trips] = []
    
    @IBOutlet var tripTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as! TripsTableViewCell
        
        cell.tripLabel.text = trips[indexPath.row].destination
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trips> = Trips.fetchRequest()
        
        do{
            trips = try managedContext.fetch(fetchRequest)
            tripTableView.reloadData()
        } catch {
            print("Could not fetch categories")
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Push", let destination = segue.destination as? EntriesTableViewController,
            let row = tripTableView.indexPathForSelectedRow?.row {
            
            destination.trips = trips[row]
        }
    
    }

    func deleteCategory(at indexPath: IndexPath){
        let trip = trips[indexPath.row]
        guard let managedContext = trip.managedObjectContext else{
            return
        }
        managedContext.delete(trip)
        do{
            try managedContext.save()
            trips.remove(at: indexPath.row)
            tripTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch{
            print("Can't delete")
            tripTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCategory(at: indexPath)
        }
    }

}
