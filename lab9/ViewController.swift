//
//  ViewController.swift
//  lab9
//
//  Created by Arin Houck on 11/16/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func findEarthquakes(sender: AnyObject) {
        if (locationTextField.text!.isEmpty) { // Validation for email and password
            self.alert("Login", message: "Please enter an location.", buttonText: "Okay")
            return
        }
        
        self.performSegueWithIdentifier("findEarthquakes", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "findEarthquakes"
        {
            let dest: EarthquakeTableViewController =  segue.destinationViewController as! EarthquakeTableViewController
            dest.location = locationTextField.text!
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    private func alert(title: String, message: String, buttonText: String) {
        let alertView = UIAlertView();
        alertView.title = title
        alertView.message = message
        alertView.addButtonWithTitle(buttonText)
        alertView.show()
    }

}

