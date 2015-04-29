//
//  tableVC.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 4/29/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation

class tableVC: UITableViewController {
    
    var tableV  = UITableView()
    var chartLegend: [String] = []
    var chartBGData: [Int] = []
    var chartA1CData: [Double] = []
    var Data = [UserHealth]()
    var a1c = [UserA1C]()
    
    override func viewDidLoad() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LogCell")
        super.viewDidLoad()
        for var i=0; i < Data.count; i++ {
            var date =  Data[i].dateTime
            var BGR =  Data[i].bloodSugarReading
            
            var dateForm = NSDateFormatter()
            dateForm.dateFormat = "MM-dd 'at' HH:mm"
            var datee = dateForm.stringFromDate(date)
            println("Date: " + datee)
            let x : Int = Int(BGR)
            var BGRString = String(x)
            println("BGR: ", x)
            chartLegend.append(datee)
            chartBGData.append(x)
        }
        for var j = 0; j < a1c.count; j++ {
            var date = a1c[j].dateTime
            var A1c = a1c[j].a1c
            
            var dateForm = NSDateFormatter()
            dateForm.dateFormat = "MM-dd 'at' HH:mm"
            var datee = dateForm.stringFromDate(date)
            println("Date: " + datee)
            
            var c:String = String(format:"%.1f", A1c)
            println("a1c: \(c)") // c: 1.5
            
            chartLegend.append(datee)
            chartA1CData.append(A1c)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    From ViewController (original) ----------------------------------------------------------------------
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // println("Can find a user in CD: ", userData.count)
    println("Number of logs (reg): ", userData.count)
    println("Number of logs (A1C): ", userA1CData.count)
    return (userData.count + userA1CData.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    logTable.dataSource = self
    logTable.delegate = self
    logTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
    let cell:UITableViewCell = logTable.dequeueReusableCellWithIdentifier("LogCell", forIndexPath: indexPath) as UITableViewCell
    
    // Get the LogItem for this index
    let logItem = userData[indexPath.row].dateTime
    let BGR = userData[indexPath.row].bloodSugarReading
    
    var outputFormat = NSDateFormatter()
    outputFormat.locale = NSLocale(localeIdentifier:"en_US")
    outputFormat.dateFormat = "MM-dd-yyyy 'at' HH:mm"
    var newDate = outputFormat.stringFromDate(logItem)
    // Set the title of the cell to be the title of the logItem
    cell.textLabel?.text = newDate
    cell.textLabel?.textColor = UIColor .blackColor()
    cell.detailTextLabel?.text = String(BGR)
    cell.detailTextLabel?.textColor = UIColor .redColor()
    
    return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let logItem = userData[indexPath.row].dateTime
    var outputFormat = NSDateFormatter()
    outputFormat.locale = NSLocale(localeIdentifier:"en_US")
    outputFormat.dateFormat = "MM-dd-yyyy 'at' HH:mm"
    var newDate = outputFormat.stringFromDate(logItem)
    println(newDate)
    }

*/
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Count for chartLegend is: " + String(chartLegend.count))
        return (chartLegend.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("LogCell", forIndexPath: indexPath) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "LogCell")
        }
        
        if(indexPath.row < chartBGData.count){
            cell!.textLabel?.text = "Time: " + chartLegend[indexPath.row] + " |  BG: " + String(chartBGData[indexPath.row])
        }
        else{
            cell!.textLabel?.text = chartLegend[indexPath.row]
            var newIndex = (indexPath.row - chartBGData.count)
            var b:String = String(format:"%.1f", chartA1CData[newIndex])
            cell!.textLabel?.text = "Time: " + chartLegend[indexPath.row] + " |  A1C: " + b
        }
        return cell!
    }

    
}