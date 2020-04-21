//
//  MonthPickerView.swift
//  MonthPicker
//
//  Created by Gustavo Paris on 20/04/2020.
//  Copyright © 2020 Gustavo Paris. All rights reserved.
//

import UIKit

class MonthPickerView : UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var months: [String]!
    var years: [Int]!
    var DEFAULT_SIZE = 204
    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month - 1, inComponent: 0, animated: true)
        }
    }
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            selectRow(years.firstIndex(of: year)!, inComponent: 1, animated: true)
        }
    }
    
    func onDateSelected() -> String {
        return "\(month)-\(year)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        // population years
        var years: [Int] = []
        if years.count == 0 {
            for i in (currentYear - DEFAULT_SIZE)...(currentYear + DEFAULT_SIZE) {
                years.append(i)
            }
        }
        self.years = years
        
        // population months with localized names
        var months: [String] = []
        var month = 0
        for _ in 1...12 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months
        
        self.delegate = self
        self.dataSource = self
        
        // TODO check currentMonth relative to infinite size
        self.selectRow((DEFAULT_SIZE / 2) - 7 + currentMonth, inComponent: 0, animated: true)
        self.selectRow(DEFAULT_SIZE, inComponent: 1, animated: true)
    }
    
    // number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
      
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return DEFAULT_SIZE
            case 1:
                return years.count
            default:
                return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
            case 0:
                return months[row % months.count]
            case 1:
                return "\(years[row])"
            default:
                return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = self.selectedRow(inComponent: 0)+1
        let year = years[self.selectedRow(inComponent: 1)]
        self.month = month
        self.year = year
    }
    
}
