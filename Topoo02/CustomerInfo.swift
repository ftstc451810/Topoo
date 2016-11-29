//
//  CustomerInfo.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/11.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CustomerInfo{
    var teaList = [Tea]()
    var totalPrice = 0
    var teaMaterialNumber = 0
    var orderName = ""
    var receiverName = ""
    var email = ""
    var phone = ""
    var cellphone = ""
    var postalCode = ""
    var country = ""
    var city = ""
    var completeAddress = ""
    var payWay = ""     //直接取付款方式segment的值
    var receiveTime = ""  // time array資料
    var words = ""
}