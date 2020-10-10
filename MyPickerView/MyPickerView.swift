//
//  MyPickerView.swift
//  MyPickerView
//
//  Created by Puji Wahono on 09/10/20.
//  Copyright © 2020 Puji Wahono. All rights reserved.
//

import UIKit

public class MyPickerView: UIPickerView ,  UIPickerViewDataSource, UIPickerViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    typealias completionDataSelectedHandler =  (_ data:String?,_ row:Int?) -> Void
    var dataSelected : completionDataSelectedHandler?
    
    /**
     The data for the `UIPickerViewDelegate`
     
     Always needs to be an array of `String`! The `UIPickerView` can ONLY display Strings
     */
    public var data: [String]? {
        didSet {
            super.delegate = self
            super.dataSource = self
            self.reloadAllComponents()
        }
    }
    

    /**
     Stores the UITextField that is being edited at the moment
     */
    public var textFieldBeingEdited: UITextField?

    /**
     Get the selected Value of the picker
     */
    public var selectedValue: String {
        get {
            if data != nil {
                if  let data = data  {
                     return data[selectedRow(inComponent: 0)]
                } else {
                    return ""
                }
            } else {
                return ""
            }
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if data != nil {
            if  let data = data  {
                 return data.count
            } else {
                return 0
            }
           
        } else {
            return 0
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if data != nil {
            return data![row]
        } else {
            return ""
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let data = data else {return}
        let datas = data[row]
        guard let dataSelected = dataSelected else {return}
        dataSelected(datas, row)
       }
    
    public func getDatasSelected(completionHandler:@escaping (_ data:String,_ row:Int) -> Void)  {
        dataSelected = { data , row in
            completionHandler(data ?? "", row ?? 0)
        }
    }

}
