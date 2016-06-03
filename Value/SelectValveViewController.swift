//
//  SelectValveViewController.swift
//  Value
//
//  Created by Johnny on 6/2/16.
//  Copyright © 2016 ExxonMobil. All rights reserved.
//

import UIKit

class SelectValveViewController: UIViewController, UIPickerViewDataSource ,UIPickerViewDelegate {

    @IBOutlet weak var pickerViewValve: UIPickerView!
    let valves:[String] = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12"]
    var valve:String!
    var delegate:AddTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerViewValve.dataSource = self;
        self.pickerViewValve.delegate = self;
        
        // Set First Value as Selected
        self.title = valves[0]
        self.valve = valves[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.valves.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return valves[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.valve = valves[row]
        self.title = valves[row]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func selectValve(sender: AnyObject) {
        
        self.delegate?.valveSelected(self.valve)
        
        // Return to previous screen
        if let navigation = self.navigationController {
            navigation.popViewControllerAnimated(true)
        }
    }
    
}
