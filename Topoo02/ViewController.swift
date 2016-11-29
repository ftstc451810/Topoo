//
//  ViewController.swift
//  Topoo02
//
//  Created by Ｍac on 2016/8/2.
//  Copyright © 2016年 MongZ. All rights reserved.
//

import UIKit
import Parse
class ViewController: UIViewController, UITableViewDelegate {   //add: UITableViewDelegate, tableview找一個代理只要在代理上動作，就等於對自己動作....but 目前沒用
    
    var allTea: [Tea] = []
    var someTea: [Tea] = []
    var tea: [Tea] = []
    var customTea: [Tea] = []
    var existedTea: [Tea] = []
    var savecustomTea: [Tea] = []
    var cellDic = Dictionary<String, Array<String>>() //number text field, changed color, change package (cell)
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
//        let teaQuery = PFQuery(className: "Tea")
//        teaQuery.orderByAscending("location")
//        teaQuery.findObjectsInBackgroundWithBlock {(result: [PFObject]?, error: NSError?) -> Void in
        
        ParseHelper.teaRequestForCurrentUser {
            (result: [PFObject]?, error: NSError?) -> Void in
//
        // result is an array of dictionary (Tea parse list)
        // let firstTea = result![0]
        // firstTea["Name"]    //Austin's example
            
            if let count = (result?.count){
                for index in 0..<count{
                    let teaItem = Tea()
                    if let teaRow = result?[index]{
                        teaItem.name = teaRow["Name"] as! String
                        teaItem.price = teaRow["HPrice"] as! String
                        teaItem.location = teaRow["location"] as! String
                        teaItem.type = teaRow["Type"] as! String
                        //teaItem.image = teaRow["imageFile"] as! PFFile
                        
                        do {
                            // 2
                            let data = try (teaRow["imageFile"] as! PFFile).getData()
                            // 3
                            teaItem.image.value = UIImage(data: data, scale:1.0)!   //initializer
                        } catch {
                            print("could not get image")
                        }
                        teaItem.package = teaRow["Package"] as! String
                        self.allTea.append(teaItem)
                        self.tea = self.allTea
                    }
                    
                }
                self.tableView.reloadData()  //when adding new information, we have to tell the view to update
            }
            
//            print("number 1")
        }
        
//        print("number 2")  //"number 2" will print first (since inbackground operate in other thread and the main thread will continue to print "number 2")
        
        
    }
    @IBAction func AllTeaButton(sender: UIButton) {
        tea = allTea
        self.tableView.reloadData()
    }
    @IBAction func GreenTeaButton(sender: UIButton) {
        someTea = []
        for tea in allTea{
            if tea.type == "green"{
                someTea.append(tea)
            }
        }
        tea = someTea
        self.tableView.reloadData()
    }
    @IBAction func OolongTeaButton(sender: UIButton) {
        someTea = []
        for tea in allTea{
            if tea.type == "oolong"{
                someTea.append(tea)
            }
        }
        tea = someTea
        self.tableView.reloadData()
    }
    @IBAction func RedTeaButton(sender: UIButton) {
        someTea = []
        for tea in allTea{
            if tea.type == "black"{
                someTea.append(tea)
            }
        }
        tea = someTea
        self.tableView.reloadData()
    }

    
    @IBAction func orderLower(sender: UIButton) {
//        func swap(first: Int, second: Int){
//            var t = first
//            first = second
//        }
        func swap(first:Int, second: Int){
            var temp = Tea()
            temp = tea[first]
            tea[first] = tea[second]
            tea[second] = temp
        }
        
        for i in 0..<tea.count-1{
            var largest = Int(tea[i].price)
            var position = i
            for j in i+1..<tea.count{
                if(largest < Int(tea[j].price)){
                    largest = Int(tea[j].price)
                    position = j
                }
            }
            swap(i, second: position)
        }
        self.tableView.reloadData()
    }
    
    
    
    @IBAction func orderHigher(sender: UIButton) {
        func swap(first:Int, second: Int){
            var temp = Tea()
            temp = tea[first]
            tea[first] = tea[second]
            tea[second] = temp
        }
        
        for i in 0..<tea.count-1{
            var smallest = Int(tea[i].price)
            var position = i
            for j in i+1..<tea.count{
                if(smallest > Int(tea[j].price)){
                    smallest = Int(tea[j].price)
                    position = j
                }
            }
            swap(i, second: position)
        }
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if customTea.isEmpty && existedTea.isEmpty{
            return false
        }
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueToCart") {
           
//            if customTea.isEmpty{
//                //disable segue
//                
//            }else{    //can't stop segue here
                let cvc = segue.destinationViewController as! CartViewController
            if existedTea.isEmpty{
                cvc.teaChosen = customTea
            }else{
                if customTea.isEmpty{  //因為要回傳existedTea即使沒有在新選東西，如果只寫下面那一段根本不會有東西放到teaChosen內(for迴圈不會run)
                    cvc.teaChosen = existedTea
                }else{
                    for i in 0..<customTea.count{  //加了unwindsegue後，customTea不會清空，所以cvc會一直累加
                        existedTea.append(customTea[i])  //after customers select some items
                        cvc.teaChosen = existedTea
                    }
                }
            }
            
            //為了customer在cvc delete some cell 要改變cellDic 的顏色項目
            
        }
    }
    
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        customTea = []      //(客戶要再選)
        //print("\(existedTea[0].name)\(existedTea[existedTea.count-1].name)")  //for test因為只有一個cell變成dark
        tableView.reloadData()
    }
    
  
    @IBAction func addNumber(sender: UIStepper) {
        let cell3 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0)) as! ProductTableViewCell
        cell3.productNumber.text = Int(sender.value).description
        if cellDic[cell3.productNameLabel.text!] == nil{   //if without the key create a new one
            cellDic[cell3.productNameLabel.text!] = ["0","white","-1"]
//            cellDic[sender.tag]?.append("white")
            cellDic[cell3.productNameLabel.text!]![0] = cell3.productNumber.text!
        }else{
            cellDic[cell3.productNameLabel.text!]![0] = cell3.productNumber.text!
        }
    }
    
       @IBAction func cartButton(sender: UIButton) {
        
//        let cell:UITableViewCell = tableView(self.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0))  //呼叫下方tableView method就只是要騎在create一個新的cell並非選到的那個cell
//        let cell2 = cell as! ProductTableViewCell   //轉型
        
        let cell2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0)) as! ProductTableViewCell  //一定要告訴他是哪一種cell，才有辦法取得對應的IBoutlet
        
        if (cell2.segControl.selectedSegmentIndex != UISegmentedControlNoSegment && Int(cell2.productNumber.text!)! > 0 ){  //確保都有資料後按鈕才真有反應
            
            if customTea.isEmpty {
                
            }else{
                for i in 0..<customTea.count{  //vc資料到cvc時品項不重複
                    if(customTea[i].name == tea[sender.tag].name){
                        customTea.removeAtIndex(i)
                    }
                }
            }
            tea[sender.tag].number = cell2.productNumber.text! //要給按出去時的數量
            tea[sender.tag].chosenPackage = cell2.segControl.titleForSegmentAtIndex(cell2.segControl.selectedSegmentIndex)!   //package的內容依照選擇更改  //but後來造成重複使用cell時package辨識就改變了> Tea多一個變數放選擇後的package
            customTea.append(tea[sender.tag])   //prepare for segue
            cell2.backgroundColor = UIColor(red: 233/255, green: 1, blue: 150/255, alpha: 0.6)    //change color
            
            if cellDic[cell2.productNameLabel.text!] == nil{   //if without the key create a new one
                cellDic[cell2.productNameLabel.text!] = ["0","white","-1"]
            }
            cellDic[cell2.productNameLabel.text!]![1] = "light"
        }
    }
    
    @IBAction func packageSegForCellState(sender: UISegmentedControl) {
        let cell4 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0)) as! ProductTableViewCell

        
        if cellDic[cell4.productNameLabel.text!] == nil{   //if without the key create a new one
            cellDic[cell4.productNameLabel.text!] = ["0","white","-1"]
            //            cellDic[sender.tag]?.append("white")
        }
        if cell4.segControl.selectedSegmentIndex == 0{
            cellDic[cell4.productNameLabel.text!]![2] = "0"
        }else if cell4.segControl.selectedSegmentIndex == 1{
            cellDic[cell4.productNameLabel.text!]![2] = "1"
        }else if cell4.segControl.selectedSegmentIndex == 2{
            cellDic[cell4.productNameLabel.text!]![2] = "2"
        }
    }

}

extension ViewController: UITableViewDataSource { //dataresource，tableview從controller拿資料
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return tea.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productTableViewCell", forIndexPath: indexPath) as! ProductTableViewCell
        cell.setItem(tea[indexPath.row])
        cell.cartButton.tag = indexPath.row  //每個按鈕之後會要對應數值去變化(操控對的cell)
        cell.productStepper.tag = indexPath.row
        cell.segControl.tag = indexPath.row
//            cell.teaEvery = tea[indexPath.row]  //為了讓tea是個完整的Tea型態可以直接放入cell,直接在productcell內處理vc要display的資料
//            cell.checkTea = existedTea    //不丟到cell裡做了
        for i in 0..<existedTea.count{  //比對已選的項目並改色
            if tea[indexPath.row].name == existedTea[i].name && tea[indexPath.row].location == existedTea[i].location{
                //cell.cartButton.enabled = false
                cell.backgroundColor = UIColor(red: 136/255, green: 167/255, blue: 132/255, alpha: 0.75)
                print("\( tea[indexPath.row].name)")  //for test
                
                if cellDic[cell.productNameLabel.text!] == nil{   //if without the key create a new one (actually when the cell chosen there is data for the cell> so no need the examiner)
                    cellDic[cell.productNameLabel.text!] = ["0","white","-1"]
                }
                cellDic[cell.productNameLabel.text!]![0] = existedTea[i].number
                cellDic[cell.productNameLabel.text!]![1] = "dark"
            }else{  //為避免cell重複使用會使用已改變的設定所以設定要完整
                cell.cartButton.enabled = true
//                cell.backgroundColor = UIColor.whiteColor()  //這裡改顏色沒用因為下面的func會根據cellDic狀態改色
                if cellDic[cell.productNameLabel.text!] == nil{   //把全部cell的狀態都放進去好了也順便改之前變成light的cell
                    cellDic[cell.productNameLabel.text!] = ["0","white","-1"]
                }//為了讓在cvc被delete cell改回原本狀態
                cellDic[cell.productNameLabel.text!]![0] = "0"
                cellDic[cell.productNameLabel.text!]![1] = "white"
                cellDic[cell.productNameLabel.text!]![2] = "-1"
            }
        }
        if existedTea.count == 0 && customTea.count == 0{  //在cvc全被清空後，cellDic的狀態要全改回來&&一開始就沒有existedTea的時候還是要保留customeTea的選項
            if cellDic[cell.productNameLabel.text!] == nil{
                cellDic[cell.productNameLabel.text!] = ["0","white","-1"]
            }
            cellDic[cell.productNameLabel.text!]![0] = "0"
            cellDic[cell.productNameLabel.text!]![1] = "white"
            cellDic[cell.productNameLabel.text!]![2] = "-1"
        }
        
        
        for _ in cellDic{   //判斷個個品項的狀態不讓cell互相影響
            if cellDic[cell.productNameLabel.text!] != nil {
                cell.productNumber.text = cellDic[cell.productNameLabel.text!]![0]
                if cellDic[cell.productNameLabel.text!]![1] == "dark"{
//                  print("\(cell.productNameLabel.text!)")  //for test
                    cell.backgroundColor = UIColor(red: 136/255, green: 167/255, blue: 132/255, alpha: 0.75)
                    cell.cartButton.enabled = false   //只寫上面的for判斷拗不清楚為何沒成功，所以在這只要是dark就會disable
                }else if cellDic[cell.productNameLabel.text!]![1] == "light"{
                    cell.backgroundColor = UIColor(red: 233/255, green: 1, blue: 150/255, alpha: 0.6)
                }else{
                    cell.backgroundColor = UIColor.whiteColor()
                }
                
                if cellDic[cell.productNameLabel.text!]![2] == "0"{
                    cell.segControl.selectedSegmentIndex = 0
                }else if cellDic[cell.productNameLabel.text!]![2] == "1"{
                    cell.segControl.selectedSegmentIndex = 1
                }else if cellDic[cell.productNameLabel.text!]![2] == "2"{
                   cell.segControl.selectedSegmentIndex = 2
                }
                
            }else{
                cell.productNumber.text = "0"
                cell.backgroundColor = UIColor.whiteColor()
                cell.segControl.selectedSegmentIndex = -1
            }
        }
//            cell.productNameLabel.text = tea[indexPath.row].location + "-" + tea[indexPath.row].name
//            cell.productPriceLabel.text = "$" + tea[indexPath.row].price
//            cell.productImage.image = tea[indexPath.row].image.value

        return cell
    }
    
    
}