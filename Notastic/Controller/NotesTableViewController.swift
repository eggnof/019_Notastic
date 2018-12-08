//
//  NotesTableViewController.swift
//  Notastic
//
//  Created by Bryce Poole on 12/2/18.
//  Copyright © 2018 Bryce Poole. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    //An Array of Note items
    var noteArray = [Note]()
    
    //Setup Context for CoreData
    
    //Go into app delegate, grab reference to the persistant containers' context
    //This will act as a staging area for data that we want to save, and give us a way to save i
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    /*****************************************************************************/
    // MARK: - Table view data source
    /*****************************************************************************/
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteArray.count //Table should be equal to the number of items in noteArray
    }
    
    
    //Setup Each Item in Table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Called for each item in table
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotasticCell", for: indexPath)
        
        let item = noteArray[indexPath.row] //Configure cell at current index
        // Configure the cell...
        
        //Name the cell based on the current item
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    //A row was selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Trigger Segue
        performSegue(withIdentifier: "goToNote", sender: self)
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
    
    //Add button pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        /************************************
         *  Create Properties for out alert
         ************************************/
        
        //Create textField
        var textField = UITextField()
        
        //Create an alert for the textField
        var alert = UIAlertController(title: "Create new Note", message: "", preferredStyle: .alert)
        
        //Create an action for the alert
        var action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //TRAILING CLOSURE vvvv
            
            //Make sure the textField isn't empty
            if textField.text != "" {
                
                let newItem = Note(context: self.context)
                newItem.title = textField.text //Assign the newItems title to the current textField Value
                self.noteArray.append(newItem) //Add the newItem to the noteArray
                
                //Save new items to context
                self.saveData()
                
                //Refresh tableView data
                self.tableView.reloadData()
            }
        }//END CLOSURE ^^^^
        
        /***********************************************************
         *      Assign our properties and display alert to user
         ***********************************************************/
        
        //Add textField to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Note." //Create placeholder text for textField
            textField = alertTextField //Assign textField to alertTextField
        }
        
        //add action to alert
        alert.addAction(action)
        
        //Present the alert
        present(alert,animated: true, completion: nil)
        
    }
    
    
    /*****************************************************************************/
    // MARK: - Data Manipulation
    /*****************************************************************************/
    
    //Save data to the context
    func saveData(){
        
        //Save data from noteArray to the context
        do {
            //Try to save the data
            try context.save()
        } catch {
            print("Error saving context: \(error). ")
        }
    }
    
    //Load Data from the context
    /*******************************************************************************************************************
     *                  METHOD TO LOAD ITEMS FROM DATA MODEL INTO itemArray AND UPDATE UI
     * ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
     * Must be given the dataType of the class of item being fetched. In this case, its the data type of our Model
     *******************************************************************************************************************/
    func loadItems(with request : NSFetchRequest<Note> = Note.fetchRequest() ) {  //Using = in the argument declaration gives it a default value if one isn't passed when calling.
        
        //Try to pull data from context
        do{
            noteArray = try context.fetch(request) //Load the requested items into noteArray
        } catch {
            print("Error loading data from context: \(error).")
        }
        
    }
    
    
    

     /*****************************************************************************/
     // MARK: - Navigation
     /*****************************************************************************/
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        //Get a reference to the destination viewController as its class type
        let destination = segue.destination as! NoteViewController
        
        //Get a reference to the currently selected row (IPFSR is an optional, optionalBinding)
        if let indexPath = tableView.indexPathForSelectedRow {
            
            //A valid destination exists, Set selectedNote inside destination
            destination.selectedNote = noteArray[indexPath.row]
            destination.context = context
        }
     }

    
}
