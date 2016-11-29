//
//  ParseHelper.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/4.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import Parse

// 1
class ParseHelper {
    
     //2
    static func teaRequestForCurrentUser(completionBlock: PFQueryArrayResultBlock) {
        
        PFUser.logInWithUsernameInBackground("test", password: "test") { (PFUser, NSError) in
            let teaQuery = PFQuery(className: "Tea")
            teaQuery.orderByDescending("location")
            teaQuery.findObjectsInBackgroundWithBlock(completionBlock)
        } 
//        teaQuery.whereKey("imageFile", equalTo:PFUser.currentUser()!)
        
//        let postsFromFollowedUsers = Post.query()
//        postsFromFollowedUsers!.whereKey("user", matchesKey: "toUser", inQuery: followingQuery)
//        
//        let postsFromThisUser = Post.query()
//        postsFromThisUser!.whereKey("user", equalTo: PFUser.currentUser()!)
        
//        let query = PFQuery.orQueryWithSubqueries([teaQuery, teaQuery])
////        query.includeKey("user")
//
//        
//        // 3
        
    }
}