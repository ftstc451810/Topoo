//
//  ChosenTableViewCell.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/5.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import UIKit
import Bond

class ChosenTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var chosenImageView: UIImageView!
    
    @IBOutlet weak var chosenName: UILabel!
    @IBOutlet weak var chosnePackage: UILabel!
    @IBOutlet weak var chosenPrice: UILabel!
    
    @IBOutlet weak var chosenAmount: UITextField!
    
    var lastStepperValue = 0.0
    
    @IBOutlet weak var chosenStepperForValue: UIStepper!
//    @IBAction func chosenStepper(sender: UIStepper) {
//            chosenAmount.text = Int(sender.value).description  //移到外面為了存進teaChosen > 變成用stepper的IBOutlet
    
//    }
        //(這樣會改變原本的數量，從0開始加)不過下面一開始cell被create的時候就設定了stepper的value
//        var temp = Int(chosenAmount.text!)
//        temp = temp! + Int(sender.value)
//        chosenAmount.text = temp?.description  //改變一次後會累加那一次的chosenAmount
//        chosenAmount.text = String(Int(sender.value) + Int(chosenAmount.text!)!)  //會累加還不能減
        
    //要使用原本的內容，sender.value控制項
        //var originAmount = Double(chosenAmount.text!)
//        if sender.value > lastStepperValue{
//            let temp = Double(chosenAmount.text!)! + 1.0
//            chosenAmount.text = Int(temp).description
//            lastStepperValue += 1.0
//        }else{          //可以加減了可是扣到sender == 0 時就無法再扣了...
//            var temp = Double(chosenAmount.text!)! - 1.0
//            if temp < 0 {temp = 0}
//            chosenAmount.text = Int(temp).description
//            if lastStepperValue > 0 {
//                lastStepperValue -= 1.0
//            }
//            
//        }
//        if sender.value == 0 {
//            var temp = Double(chosenAmount.text!)! - 1.0
//            if temp < 1 {temp = 1}
//            chosenAmount.text = Int(temp).description
//        }   //寫了這段反而會一次扣2
    
    func setItem(teaChosen: Tea){
        self.chosenImageView.image = teaChosen.image.value
        self.chosenName.text = teaChosen.location + "-" + teaChosen.name
        self.chosnePackage.text = teaChosen.chosenPackage
        let calculatedPrice: Int = Int(teaChosen.price)! * Int(teaChosen.number)!
        self.chosenPrice.text = "$" + Int(calculatedPrice).description
        //轉型成數字計算後放回
        self.chosenAmount.text = teaChosen.number
        self.chosenStepperForValue.value = Double(teaChosen.number)!   //因為要跟著已有的量加減，而非從頭開始計
    }
}