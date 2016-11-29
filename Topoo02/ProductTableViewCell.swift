//
//  ProductTableViewCell.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/2.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import Foundation
import UIKit
import Bond

class ProductTableViewCell: UITableViewCell {
    var checkTea: [Tea] = []
    
    @IBOutlet weak var productImage: UIImageView!
//    var teaEvery:Tea!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var productPriceLabel: UILabel!
//    @IBAction func productWeightSeg(sender: UISegmentedControl) {
//        switch segControl.selectedSegmentIndex{
//        case 0:
//            productPriceLabel.text = "$1000"
//        case 1:
//            productPriceLabel.text = "$1800"
//        case 2:
//            productPriceLabel.text = "$3500"
//        default:
//            break
//        }
//        
//    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        
//    }
    
    func setItem(teaEvery:Tea) {
        
        
        self.productNameLabel.text = teaEvery.location + "-" + teaEvery.name
        self.productPriceLabel.text = "$" + teaEvery.price
        self.productImage.image = teaEvery.image.value
        
        if(teaEvery.package == "四兩裝/半斤裝"){
            self.segControl.setEnabled(false, forSegmentAtIndex: 2)
            self.segControl.setEnabled(true, forSegmentAtIndex: 0)
            self.segControl.setEnabled(true, forSegmentAtIndex: 1)  //為避免cell重複使用會使用已改變的設定所以設定要完整
        }else if(teaEvery.package == "四兩裝"){
            self.segControl.setEnabled(false, forSegmentAtIndex: 2)
            self.segControl.setEnabled(false, forSegmentAtIndex: 1)
            self.segControl.setEnabled(true, forSegmentAtIndex: 0)
        }else if(teaEvery.package == "半斤裝"){
            self.segControl.setEnabled(false, forSegmentAtIndex: 0)
            self.segControl.setEnabled(false, forSegmentAtIndex: 2)
            self.segControl.setEnabled(true, forSegmentAtIndex: 1)
        }else{
            self.segControl.setEnabled(false, forSegmentAtIndex: 0)
            self.segControl.setEnabled(false, forSegmentAtIndex: 1)
            self.segControl.setEnabled(true, forSegmentAtIndex: 2)
        }
        
        


    }
    
// 初始化設定cell在這無法用因為資料還沒被放入會error
//      required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
////        fatalError("init(coder:) has not been implemented")
//        
//        
//    }
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
////        if self.tea != nil {
//        
////        }
//    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    @IBOutlet weak var productStepper: UIStepper!

    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var productNumber: UITextField!
//    @IBAction func productSetter(sender: UIStepper) {
//        productNumber.text = Int(sender.value).description
        //搬出去為了存取cell狀態
//        
//        if let numberString = productNumber.text{
//            var number = Int(numberString)!
//            number += 1
//            productNumber.text = String(number)
//        }  這樣不管按+-一律都會增加數量
        
    }

//        
//    var tea: Tea? {
//        didSet {
//            // 1
//            if let tea = tea {
//                //2
//                // bind the image of the post to the 'postImage' view
//                tea.image.bindTo(productImage.bnd_image)
//            }
//        }
//    }
    
   