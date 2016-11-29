//
//  TeaInfo.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/4.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import Parse

// 1
//class TeaInfo : PFObject, PFSubclassing {
//    
//    // 2
//    @NSManaged var imageFile: PFFile?
//    
//    //MARK: PFSubclassing Protocol
//    
//    // 3
//    static func parseClassName() -> String {
//        return "TeaInfo"
//    }
//    
//    // 4
//    override init () {
//        super.init()
//    }
//    
//    override class func initialize() {
//        var onceToken : dispatch_once_t = 0;
//        dispatch_once(&onceToken) {
//            // inform Parse about this subclass
//            self.registerSubclass()
//        }
//    }
//    
//}