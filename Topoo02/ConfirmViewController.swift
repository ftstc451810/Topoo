//
//  ViewController.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/2.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var confirmTableView: UITableView!
    
    var finalCustomerInfo = CustomerInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "editInfo" {
            let cvc = segue.destinationViewController as! CartViewController
            
        }
    }
}

extension ConfirmViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        
        let cell = tableView.dequeueReusableCellWithIdentifier("confirm", forIndexPath: indexPath) as! ConfirmTableViewCell
            cell.setItem(finalCustomerInfo)
            return cell
        
        
    }
    
    
}