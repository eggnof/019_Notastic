//
//  NoteViewController.swift
//  Notastic
//
//  Created by Bryce Poole on 12/3/18.
//  Copyright © 2018 Bryce Poole. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UITextViewDelegate {
    
    /******************
     //  IB OUTLETS
     ******************/
    @IBOutlet weak var textView: UITextView!
    
    /******************
    //  GLOBAL VARS
    ******************/
    

    
    //Setup note field for user to enter text into
    var note = UITextField()
    
    //Go into app delegate, grab reference to the persistant containers' context
    //This will act as a staging area for data that we want to save, and give us a way to save i
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //An optional placeholder of Note. When transitioning from NotesTableViewController the selected category gets assigned here through prepareForSegue
    var selectedNote : Note? {
        
        //Did set gets auto called when selectedCategory gets assigned
        didSet{
            //Load any persisted data from app documents, passing the request item as the container for results
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                print( FileManager.default.urls(for: .documentDirectory , in: .userDomainMask ) )//DEBUG
        
        //This class is the delegate for textView
        textView!.delegate = self

    }
    
    /*****************************************************************************/
    // MARK: - TextField Update Methods
    /*****************************************************************************/
    
    func textViewDidChange(_ textView: UITextView) {
        
        
        print("Trying to save data")
        
//        context.setValue(textView.text, forKey: "title")
//        let newItem = Note(context: self.context)
//        newItem.title = selectedNote?.title
//        newItem.contents = textView.text
        
//
//        noteReference.setValue(textView.text, forKey: (selectedNote!.title)!)
        
        saveData()
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
    func loadItems(with request : NSFetchRequest<Note> = Note.fetchRequest() , predicate : NSPredicate? = nil ) {  //Using = in the argument declaration gives it a default value if one isn't passed when calling.
        
//        if predicate != nil {
            //Create a filter that only returns Note objects that match the title of selectedNote
            request.predicate = NSPredicate(format: "title == %@", selectedNote!.title! )
//        }

        //Try to pull data from context
        do{
            var loadedNotes = try context.fetch(request) //Load the requested items into noteArray
            textView?.text = loadedNotes[0].contents //Assign the loaded notes contents to the UITextField
            print("Loaded these items: \(loadedNotes)")
        } catch {
            print("Error loading data from context: \(error).")
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
