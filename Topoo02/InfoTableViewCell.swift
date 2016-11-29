//
//  InfoTableViewCell.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/5.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import UIKit
import Bond

class InfoTableViewCell: UITableViewCell{
    var time = [String]()
   
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var recieverText: UITextField!
    @IBAction func sameButton(sender: UIButton) {
    }
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var cellphoneText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    
    @IBOutlet weak var countryPickerView: UIPickerView!
    
    
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var addressText: UITextField!
    
    @IBOutlet weak var paySegment: UISegmentedControl!
    
    @IBOutlet weak var unlimitedFor: UIButton!  //直接利用action 的 sender，就不需要再拉一個btn > 好像還是需要
    @IBAction func unlimitedTime(sender: UIButton) {
//        if unlimitedFor.state == UIControlState.Normal{
////            unlimitedFor.enabled = false    //會直接把btn按掉無法再打開
////            unlimitedFor.state = UIControlState.Highlighted
//            unlimitedFor.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
//            time.append("任何時刻")
//        }else {
//            unlimitedFor.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
//            for i in 0..<time.count{
//                if time[i] == "任何時刻"{
//                    time.removeAtIndex(i)
//                }
//            }
//        }
        
        if unlimitedFor.backgroundColor == nil{  //default沒有背景色
            //unlimitedFor.titleLabel!.textColor = UIColor.grayColor()
            sender.backgroundColor = UIColor.lightGrayColor()
            time.append("任何時刻")
        }else{
            unlimitedFor.backgroundColor = nil
            for i in 0..<time.count{
                if time[i] == "任何時刻"{
                    time.removeAtIndex(i)
                }
            }
        }
        //print(time) //for test
    }
    
    @IBOutlet weak var morningFor: UIButton!
    @IBAction func inMorning(sender: AnyObject){
        if morningFor.backgroundColor == nil{
            morningFor.backgroundColor = UIColor.lightGrayColor()
            time.append("早上9:00~12:00")
        }else{
            morningFor.backgroundColor = nil
            for i in 0..<time.count{
                if time[i] == "早上9:00~12:00"{
                    time.removeAtIndex(i)
                }
            }
        }
    }
    
    @IBOutlet weak var afternoonFor: UIButton!
    @IBAction func inAfternoon(sender: AnyObject) {
        
        if afternoonFor.backgroundColor == nil{
            afternoonFor.backgroundColor = UIColor.lightGrayColor()
            time.append("下午12:30~17:00")
        }else{
            afternoonFor.backgroundColor = nil
            for i in 0..<time.count{
                if time[i] == "下午12:30~17:00"{
                    time.removeAtIndex(i)
                }
            }
        }
    }

    @IBOutlet weak var nightFor: UIButton!
    @IBAction func atNight(sender: AnyObject) {
        if nightFor.backgroundColor == nil{
            nightFor.backgroundColor = UIColor.lightGrayColor()
            time.append("晚上17:00~21:00")
        }else{
            nightFor.backgroundColor = nil
            for i in 0..<time.count{
                if time[i] == "晚上17:00~21:00"{
                    time.removeAtIndex(i)
                }
            }
        }
    }
    
    @IBOutlet weak var comment: UITextView!
}






