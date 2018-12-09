//
//  NoteViewController.swift
//  Notastic
//
//  Created by Bryce Poole on 12/3/18.
//  Copyright © 2018 Bryce Poole. All rights reserved.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController, UITextViewDelegate {
    
    /******************
     //  IB OUTLETS
     ******************/
    @IBOutlet weak var textView: UITextView!
    
    /******************
    //  GLOBAL VARS
    ******************/
    
    //Setup new Realm object to be used by this class
    let realm = try! Realm()

    
    //An optional placeholder of Note. When transitioning from NotesTableViewController the selected category gets assigned here through prepareForSegue
    var selectedNote : Note? {
        
        //Did set gets auto called when selectedCategory gets assigned
        didSet{
            
//            print("Just loaded note: \(selectedNote?.title)") //DEBUG


        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                print( FileManager.default.urls(for: .documentDirectory , in: .userDomainMask ) )//DEBUG
        
        //This class is the delegate for textView
        textView!.delegate = self

        //Load persisted data for selected note from Realm DB
        loadNote(with: selectedNote!)
    }
    
    /*****************************************************************************/
    // MARK: - TextField Update Methods
    /*****************************************************************************/
    
    func textViewDidChange(_ textView: UITextView) {
        
        
        print("Trying to save data")
        
        
        //Make sure the selectedNote exists before trying to access it
        if let targetNote = selectedNote{
            
            do{
                //Try to write a change
                try realm.write {
                    
                    //Put the change you want to make to your data here, inside the write block. EG:
                    targetNote.contents = textView.text //Making a change to existing targetNote data.
                }
            } catch {
                print("Error saving note contents \(error)")
            }
        }

    }

    /*****************************************************************************/
    // MARK: - Data Manipulation
    /*****************************************************************************/
    
    //Method for saving data to realm
//    func save(category: Category){ //Here Category refers to the class of object thats being saved, change to fit your code!
    
//        do {
//            //Try to save the data to Realm
//            try realm.write {
//                realm.add(category)
//            }
//        } catch {
//            print("Error saving category: \(error)")
//        }
    
    //Load Data from the context
    
    
    //Load text from current Realm DB Object into VC
    func loadNote(with targetNote : Note){
  
//        print("textView is \(textView.text)")//DEBUG
//        print("Attempting to set \(targetNote.contents) to textView")//DEBUG
        
        //Set the textField's text to the selected notes contents
        textView.text = targetNote.contents
        
    }
    
    
    /*******************************************************************************************************************
     *                  METHOD TO LOAD ITEMS FROM DATA MODEL INTO itemArray AND UPDATE UI
     * ————————————————————————————————————————————————————————————————————————————————————————————————————————————————
     * Must be given the dataType of the class of item being fetched. In this case, its the data type of our Model
     *******************************************************************************************************************/
//    func loadItems(with request : NSFetchRequest<Note> = Note.fetchRequest() , predicate : NSPredicate? = nil ) {  //Using = in the argument declaration gives it a default value if one isn't passed when calling.
//
////        if predicate != nil {
//            //Create a filter that only returns Note objects that match the title of selectedNote
//            request.predicate = NSPredicate(format: "title == %@", selectedNote!.title! )
////        }
//
//        //Try to pull data from context
//        do{
//            var loadedNotes = try context.fetch(request) //Load the requested items into noteArray
//            textView?.text = loadedNotes[0].contents //Assign the loaded notes contents to the UITextField
//            print("Loaded these items: \(loadedNotes)")
//        } catch {
//            print("Error loading data from context: \(error).")
//        }
//
//    }


}
