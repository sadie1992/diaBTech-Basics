//
//  GraphVC.swift
//  diaBTech-Basics
//
//  Created by Mercedes Streeter on 4/6/15.
//  Copyright (c) 2015 Mercedes Streeter. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GraphVC: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {
    
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lineGraph: JBLineChartView!
    
    var chartLegend: [String] = []
    var chartBGData: [Int] = []
    var chartA1CData: [Double] = []
    var Data = [UserHealth]()
    var a1c = [UserA1C]()
    var inclA1C = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check that A1C was passed correctly
        /*
        for every entry in the health array, 
        add the date to chartLegend and 
        the BGR to chart BGData 
    */
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
        if inclA1C {
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
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        // line chart setup
        lineGraph.backgroundColor = UIColor.darkGrayColor()
        lineGraph.delegate = self
        lineGraph.dataSource = self
        lineGraph.minimumValue = 0
        lineGraph.maximumValue = 600
        lineGraph.reloadData()
        lineGraph.setState(.Collapsed, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        readingLabel.transform = CGAffineTransformMakeRotation( 3.14/2 );
        var footerView = UIView(frame: CGRectMake(0, 0, lineGraph.frame.width, 16))
        
        println("viewDidLoad: \(lineGraph.frame.width)")
        
        var footer1 = UILabel(frame: CGRectMake(0, 0, lineGraph.frame.width/2 - 8, 16))
        footer1.textColor = UIColor.whiteColor()
        footer1.text = "\(chartLegend[0])"
        
        var footer2 = UILabel(frame: CGRectMake(lineGraph.frame.width/2 - 8, 0, lineGraph.frame.width/2 - 8, 16))
        footer2.textColor = UIColor.whiteColor()
        footer2.text = "\(chartLegend[chartLegend.count - 1])"
        footer2.textAlignment = NSTextAlignment.Right
        
        footerView.addSubview(footer1)
        footerView.addSubview(footer2)
        
        var header = UILabel(frame: CGRectMake(0, 0, lineGraph.frame.width, 50))
        header.textColor = UIColor.whiteColor()
        header.font = UIFont.systemFontOfSize(24)
        header.text = ""
        header.textAlignment = NSTextAlignment.Center
        
        lineGraph.footerView = footerView
        lineGraph.headerView = header
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // our code
        lineGraph.reloadData()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    
    func hideChart() {
        lineGraph.setState(.Collapsed, animated: true)
    }
    
    func showChart() {
        lineGraph.setState(.Expanded, animated: true)
    }
    
    // MARK: JBlineChartView
    
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 2
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0) {
            return UInt(chartBGData.count)
        } else if (lineIndex == 1) {
            return UInt(chartA1CData.count)
        }
        
        return 0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if (lineIndex == 0) {
            return CGFloat(chartBGData[Int(horizontalIndex)])
        } else if (lineIndex == 1) {
            return CGFloat(chartA1CData[Int(horizontalIndex)])
        }
        
        return 0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0) {
            return UIColor.greenColor()
        } else if (lineIndex == 1) {
            return UIColor.yellowColor()
        }
        
        return UIColor.lightGrayColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return true }
        else if (lineIndex == 1) { return false }
        
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.greenColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        if (lineIndex == 0) { return false }
        else if (lineIndex == 1) { return true }
        
        return true
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
        if (lineIndex == 0) {
            let data = chartBGData[Int(horizontalIndex)]
            let key = chartLegend[Int(horizontalIndex)]
            timeLabel.text = "Reading on \(key): \(data)"
        } else if (lineIndex == 1) {
            let data = chartA1CData[Int(horizontalIndex)]
            let key = chartLegend[Int(horizontalIndex)]
            timeLabel.text = "A1C on \(key): \(data)"
        }
    }
    
    func didDeselectLineInLineChartView(lineChartView: JBLineChartView!) {
        timeLabel.text = ""
    }
    
    func lineChartView(lineChartView: JBLineChartView!, fillColorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 1) {
            return UIColor.whiteColor()
        }
        
        return UIColor.clearColor()
    }

    
}