//
//  ConfirmTableViewCell.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/8.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import UIKit

class ConfirmTableViewCell: UITableViewCell {
 
    @IBOutlet weak var gainTeaText: UITextView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var teaMaterialLabel: UILabel!

    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellphoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UITextView!
    @IBOutlet weak var payWayMethod: UILabel!
    @IBOutlet weak var receiveTimeLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    func setItem(finalCustomerInfo: CustomerInfo){
        var forgain = ""
        for i in 0..<finalCustomerInfo.teaList.count{
            forgain += "[\(finalCustomerInfo.teaList[i].location)- \(finalCustomerInfo.teaList[i].name)]"
        }
        self.gainTeaText.text = forgain
        
        self.totalPriceLabel.text = String(finalCustomerInfo.totalPrice)
        
        var forTeaMaterialNum = ""
        for i in 0..<finalCustomerInfo.teaMaterialNumber{
            forTeaMaterialNum += "🍃"
        }
        self.teaMaterialLabel.text = forTeaMaterialNum
        self.orderNameLabel.text = finalCustomerInfo.orderName
        self.receiverNameLabel.text = finalCustomerInfo.receiverName
        self.emailLabel.text = finalCustomerInfo.email
        self.phoneLabel.text = finalCustomerInfo.phone
        self.cellphoneLabel.text = finalCustomerInfo.cellphone
        self.addressLabel.text = finalCustomerInfo.completeAddress
        self.phoneLabel.text = finalCustomerInfo.payWay
        self.receiveTimeLabel.text = finalCustomerInfo.receiveTime
        self.commentText.text = finalCustomerInfo.words
        
    }
    
}