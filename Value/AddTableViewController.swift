//
//  AddTableViewController.swift
//  Value
//
//  Created by Johnny on 6/2/16.
//  Copyright © 2016 ExxonMobil. All rights reserved.
//

import UIKit
import CoreLocation



class AddTableViewController: UITableViewController, UITextFieldDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textFieldValve: UITextField!
    @IBOutlet weak var textFieldLatitude: UITextField!
    @IBOutlet weak var textFieldLongitude: UITextField!
    @IBOutlet weak var imageValve: UIImageView!
    
    var locationManager:CLLocationManager!
    var imagePicker: UIImagePickerController!
    let imageHelper:ImageHelper = ImageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldValve.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    // MARK: - Location Manager Delegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        self.textFieldLatitude.text = String(locValue.latitude)
        self.textFieldLongitude.text = String(locValue.longitude)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func valveSelected(valve: String) {
        textFieldValve.text = valve
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = segue.destinationViewController as? SelectValveViewController {
            viewController.delegate = self
        }
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.performSegueWithIdentifier("SegueAddToSelectValve", sender: self);
        return false
    }
    
    @IBAction func saveValveSubmission(sender: AnyObject) {
        
        let repository:LogRepository = LogRepository()
        let log:Log = repository.newLog()
        
        log.date = NSDate()
        log.valve = self.textFieldValve.text
        log.latitude = Double(self.textFieldLatitude.text!)
        log.longitude = Double(self.textFieldLongitude.text!)
        
        repository.save()
        
        // Return to previous screen
        if let navigation = self.navigationController {
            navigation.popViewControllerAnimated(true)
        }
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageValve.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    func imagePath (reminder: Int) -> String {
        
        // Define the specific path, image name
        
        let myImageName = "img" + String(reminder) +  ".png"
        let imagePath = imageHelper.fileInDocumentsDirectory(myImageName)
        
        return imagePath
        
    }
    
    func savePicture (reminder: Int) {
        
        if let image = imageValve.image {
            
            imageHelper.saveImage(image, path: self.imagePath(reminder))
            
        } else {
            
            // Cold not save date error
            
        }
        
    }
    

}
