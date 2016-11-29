//
//  CartViewController.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/5.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import UIKit
import Parse
class CartViewController: UIViewController, UITableViewDelegate {
    var teaChosen = [Tea]()
    var firstCustomerInfo = CustomerInfo()
     var countryArray = ["Taiwan", "China", "HongKong", "Japan", "Korea", "Thailand"]
     var pickerViewValue = ""
    @IBOutlet weak var cartTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.estimatedRowHeight = 120.0
        cartTableView.rowHeight = UITableViewAutomaticDimension  //自動調整cell高度，搭配constrain使用
        
//        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//            return UITableViewAutomaticDimension;
//        }
        
    }
    override func viewDidAppear(animated: Bool) {
        
        cartTableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "addNewTea" {
            let vc = segue.destinationViewController as! ViewController
            vc.existedTea = teaChosen            
        }else if segue.identifier == "confirmAll" {
            let confirmvc = segue.destinationViewController as! ConfirmViewController
            confirmvc.finalCustomerInfo = firstCustomerInfo
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "addNewTea"{
            return true
        }else{
            if checkInfo() == true {
                return true
            }
            return false
        }
    }
    
    @IBAction func unwindToCartViewController(segue: UIStoryboardSegue) {
            cartTableView.reloadData()
    }
    
    @IBAction func deleteTeaCell(sender: UIButton) {
        teaChosen.removeAtIndex(sender.tag)
        cartTableView.reloadData()
        print("\(teaChosen)")
    }
    
    func checkInfo() -> Bool{
        let cell2 = cartTableView.cellForRowAtIndexPath(NSIndexPath(forRow: teaChosen.count, inSection:0)) as! InfoTableViewCell
        if teaChosen.isEmpty {
            return false
        }else{
            firstCustomerInfo.teaList = teaChosen
            var tempTotalPrice = 0
            for i in 0..<teaChosen.count{
                tempTotalPrice += Int(teaChosen[i].price)!
            }
            firstCustomerInfo.totalPrice = tempTotalPrice
            firstCustomerInfo.teaMaterialNumber = tempTotalPrice/1000
        }
        
        if let name = cell2.nameText.text{
            firstCustomerInfo.orderName = name
        }else{
            return false
        }
        
        if let receiver = cell2.nameText.text{
            firstCustomerInfo.receiverName = receiver
        }else{
            return false
        }
        
        if let email = cell2.emailText.text{
            firstCustomerInfo.email = email
        }else{
            return false
        }
        
        if let phone = cell2.phoneText.text{
            firstCustomerInfo.phone = phone
        }else{
            return false
        }
        
        if let cellphone = cell2.cellphoneText.text{
            firstCustomerInfo.cellphone = cellphone
        }else{
            return false
        }
        
        if let code = cell2.codeText.text{
             firstCustomerInfo.postalCode = code
        }else{
            return false
        }
        firstCustomerInfo.country = pickerViewValue
        if let city = cell2.cityText.text{
            firstCustomerInfo.city = city
            if let address = cell2.addressText.text{
                firstCustomerInfo.completeAddress = pickerViewValue+city+address
            }else{
                return false
            }
        }else{
            return false
        }
        
        firstCustomerInfo.payWay = cell2.paySegment.titleForSegmentAtIndex(cell2.paySegment.selectedSegmentIndex)!
        
        if cell2.time.isEmpty{
            return false
        }else{
            var tempTime = ""
            for i in cell2.time{
                tempTime += "[\(i)]"
            }
            firstCustomerInfo.receiveTime = tempTime
        }
        
        if let comment = cell2.comment.text{
             firstCustomerInfo.words = comment
        }else{
            return false
        }
        
       
        //firstCustomerInfo.country = cell2.countryPickerView.valueForKey(<#T##key: String##String#>)  //沒有直接抓值的method
       
        return true
    }
    
    @IBAction func addChosenNumber(sender: UIStepper) {
        let cell3 = cartTableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0)) as! ChosenTableViewCell
        cell3.chosenAmount.text = Int(sender.value).description
        teaChosen[sender.tag].number = cell3.chosenAmount.text!
    }
    
    
}



extension CartViewController: UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teaChosen.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row != teaChosen.count {
            let cell: ChosenTableViewCell = tableView.dequeueReusableCellWithIdentifier("chosen", forIndexPath: indexPath) as! ChosenTableViewCell
            //cell.forDeleteTea = teaChosen //如果不把資料放進去就無法delete > 直接在外面做
            cell.setItem(teaChosen[indexPath.row])
            cell.deleteBtn.tag = indexPath.row
            cell.chosenStepperForValue.tag = indexPath.row
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("info", forIndexPath: indexPath) as! InfoTableViewCell
            //set the data here
            cell.countryPickerView.dataSource = self
            cell.countryPickerView.delegate = self
            return cell
        }
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return countryArray.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return countryArray[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewValue = countryArray[row]
    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        // 2
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("chosenTableViewCell", forIndexPath: indexPath) as! ChosenTableViewCell
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
////        if indexPath.row != teaChosen.count{
////            return 120.0
////        }else{
////            return 600.0
////        }
//        
//        
//    }
}