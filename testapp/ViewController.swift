//
//  ViewController.swift
//  testapp
//
//  Created by Tin on 2/1/16.
//  Copyright © 2016 Tin. All rights reserved.
//

import UIKit

protocol ImportantCommunicate{
    var textualDescription: String {get}

     func sendToBack();
}

protocol Togglable {
    mutating func toggle()
}


enum OnOffSwitch: Togglable {
    case Off, On
   
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

class ViewController: UIViewController,ImportantCommunicate {
  
    var lightSwitch = OnOffSwitch.Off;

    @IBOutlet weak var testlabel: UILabel!
    @IBOutlet weak var constraintforcenter: NSLayoutConstraint!
    
    var textualDescription: String {
        return lightSwitch == .On ? "Game On hai"
            :"Game Off hai";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        testlabel.text = textualDescription;
        
        constraintforcenter.constant = 0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tempcontrol:TestTableControllerTableViewController = segue.destinationViewController as! TestTableControllerTableViewController
        tempcontrol.message = "Get this message"
        tempcontrol.delegate = self;
    }
    
    func sendToBack() {
        lightSwitch.toggle()
        testlabel.text = textualDescription
    }
    
    



}


