//
//  NotesTableViewController.swift
//  Notastic
//
//  Created by Bryce Poole on 12/2/18.
//  Copyright © 2018 Bryce Poole. All rights reserved.
//

import UIKit
import RealmSwift

class NotesTableViewController: UITableViewController {
    
    //Make an instance of Realm for our class to use
    let realm = try! Realm()
    
    //list of all Note objects
    var notes : Results<Note>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NOTES: You can get a path to your local Realmdata base using this command
        print( Realm.Configuration.defaultConfiguration.fileURL )
        
        load()
        
    }
    
    /*****************************************************************************/
    // MARK: - Table view data source
    /*****************************************************************************/
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 1//Table should be equal to the number of items in noteArray
    }
    
    
    //Setup Each Item in Table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Called for each item in table
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotasticCell", for: indexPath)
        
        let item = notes?[indexPath.row] //Configure cell at current index
        
        //Name the cell based on the current item
        cell.textLabel?.text = item?.title
        
        return cell
    }
    
    //A row was selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("You selected this row!")
        
        //Trigger Segue
        performSegue(withIdentifier: "goToNote", sender: self)
    }
    
    
    //Add button pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        /************************************
         *  Create Properties for out alert
         ************************************/
        
        //Create textField
        var textField = UITextField()
        
        //Create an alert for the textField
        let alert = UIAlertController(title: "Create new Note", message: "", preferredStyle: .alert)
        
        //Create an action for the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //TRAILING CLOSURE vvvv
            
            //Make sure the textField isn't empty
            if textField.text != "" {
                
                let newNote = Note()
                newNote.title = textField.text ?? "No notes yet!" //Assign the newItems title to the current textField Value
                
                //Save new items to context
                self.save(note: newNote)
                
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
    
    //Method for saving data to realm
    func save(note: Note){
        
        do {
            //Try to save the data to Realm
            try realm.write {
                realm.add(note)
            }
        } catch {
            print("Error saving category: \(error)")
        }
    }
    
    //Load Data from the Realm
        //Create a function to load data from our db into our newly created container
        func load(){
            
            //Load all of this type of object from Realm db into our global categories property
            notes = realm.objects(Note.self)
            
            //Update the UI by Refreshing the data in our tableView
            tableView.reloadData()
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
        
        //Get a reference to the currently selected row (IPFSR is an optional so using optionalBinding)
        if let indexPath = tableView.indexPathForSelectedRow {
            
            //A valid destination exists, Set selectedNote inside destination
            destination.selectedNote = notes?[indexPath.row]
            
        }
    }

    
}
