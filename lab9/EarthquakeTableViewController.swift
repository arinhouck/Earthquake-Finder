//
//  EarthquakeTableViewController.swift
//  lab9
//
//  Created by Arin Houck on 11/16/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit
import MapKit
class EarthquakeTableViewController: UITableViewController {
    
    var earthquakes: Earthquakes = Earthquakes()
    
    @IBOutlet weak var earthquakeTableView: UITableView!
    var apiUrl: String? = nil
    var location: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.geoCode(location!)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func geoCode(sender: AnyObject) {
        let address = ( sender as! NSString)
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address as String) { (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                
                let north = Float(ani.coordinate.latitude.description)!
                let south = north - 10
                let east = Float(ani.coordinate.longitude.description)!
                let west = east - 10
                
                self.apiUrl = "http://api.geonames.org/earthquakesJSON?north=\(north)&south=\(south)&east=\(east)&west=\(west)&username=\(API_USERNAME)"
                self.callAPI(self.apiUrl!)
            }
        }
    }
    
    func callAPI(url:String)
    {
        
        
        let url = NSURL(string: url)!
        let urlSession = NSURLSession.sharedSession()
        
        
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            let json = NSString(data: data!, encoding: NSASCIIStringEncoding)
            self.extractJSON(json!)
            
        })
        jsonQuery.resume()
        
    }
    
    private func extractJSON(data: NSString) {
        
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        var json: AnyObject? = nil
        do {
            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
        } catch let caught as NSError {
            print("JSON Error \(caught)")
        }

        if let earthquakes_list = json!["earthquakes"] as? NSArray
        {
            
            for (var i = 0; i < earthquakes_list.count ; i++ )
            {
                if let earthquake = earthquakes_list[i] as? NSDictionary
                {
                    earthquakes.rows.append(Earthquake(earthquake: earthquake))
                }
            }
        }
        
        self.refreshTable()
    }
    
    func refreshTable() {
        dispatch_async(dispatch_get_main_queue(), {
            self.earthquakeTableView.reloadData()
            return
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return earthquakes.rows.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("earthquakeCell", forIndexPath: indexPath)

        
        cell.textLabel?.text = "\(earthquakes.rows[indexPath.row].getLatitude()) , \(earthquakes.rows[indexPath.row].getLongitude())"
        cell.detailTextLabel?.text = "\(earthquakes.rows[indexPath.row].getMagnitude())"
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
