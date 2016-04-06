//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Andre Machado Parente on 4/5/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var ageTxtField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    var swipe: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        swipe = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panHandler))
        view.addGestureRecognizer(swipe)
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panHandler() {
        
        if(swipe.velocityInView(view).y < 0) {
            
            performSegueWithIdentifier("MainToTable", sender: self)
            
        }
        else {
            print("deslizou pro lado errado!")
        }
    }

    @IBAction func salvarUsuario() {
    
    //saving content
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    
    //2
    let entity =  NSEntityDescription.entityForName("User",inManagedObjectContext:managedContext)
    
    let person = NSManagedObject(entity: entity!,insertIntoManagedObjectContext: managedContext)
    
    //3
    person.setValue(nameTxtField.text, forKey: "name")
    person.setValue(emailTxtField.text, forKey: "email")
    person.setValue(1, forKey: "password")
    person.setValue(Double(ageTxtField.text!), forKey: "age")
    
    //4
    do {
    try managedContext.save()
    //5
    userList.append(person)
    } catch let error as NSError  {
    print("Could not save \(error), \(error.userInfo)")
    }
    
    }

}

