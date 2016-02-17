//
//  TestTableControllerTableViewController.swift
//  testapp
//
//  Created by Tin on 2/1/16.
//  Copyright © 2016 Tin. All rights reserved.
//

import UIKit
import Alamofire

class TestTableControllerTableViewController: UITableViewController {

    
    var delegate:ImportantCommunicate?
    var message:String!
    var tableCount:Int!
    var finalResponse:[[String:AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 400.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableCount = 1;
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        startRequest()
        
        
        let arraynew:[Int] = [32,2,3,5]
        let sorted = arraynew.sort(){( s1,var s3)->Bool in
            print("in closure now")
            if s3<5{
                s3 = s3+5;
            }
            return s3<s1
        }
        print(sorted)
    }
    
    func startRequest(){
        Alamofire.request(.GET, "http://s3.amazonaws.com/vodassets/showcase.json", parameters:nil)
            .responseJSON { response in
            
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    
                    print("JSON: \(JSON)")
                    
                    self.finalResponse = JSON as? [[String:AnyObject]];
                    self.tableCount = self.finalResponse?.count;
                    self.tableView.reloadData()
    
                  
                }
        
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}



//MARK:- TableView Delegate
extension TestTableControllerTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCount
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomMovieCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! CustomMovieCellTableViewCell
        
        if self.finalResponse == nil{
            cell.titleHead.text = ""

        }
        else{
            let dic = self.finalResponse?[indexPath.row];
            cell.titleHead.text = dic!["headline"] as? String
            cell.titleSubHead.text = dic!["body"] as? String
            let imgArrayUrlDics:[[String:AnyObject]] = dic!["cardImages"] as! [[String:AnyObject]]
            let imgUrlDic:[String:AnyObject] = imgArrayUrlDics[0]
            let finalurl:String = imgUrlDic["url"] as! String
           
            
            cell.movieImage.imageFromUrl(finalurl)
            
            //cell is being moved from here to new branch okay??/
            
        }

//        cell.imageView?.image = UIImage(
        // Configure the cell...
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableCount = tableCount-1;
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.sendToBack()
        self.performSegueWithIdentifier("detailshow", sender: nil)
        
    }
    
 
    

}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                self.image = UIImage(data: data!)
            }
        }
    }
}
