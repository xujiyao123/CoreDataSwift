//
//  ViewController.swift
//  CodeDataBySwift
//
//  Created by 徐继垚 on 15/9/9.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{

    var tableView : UITableView!
    var dataSources = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appdelegaet = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appdelegaet?.managedObjectContext
        let request  = NSFetchRequest(entityName: "LogIn")
        
        do {
            let fetchResults = try context!.executeFetchRequest(request) as? [LogIn]
            
          //  self.dataSources = fetchResults!
            
            print(fetchResults)
            
        } catch let fetchError as NSError {
            print("获取用户名错误: \(fetchError.localizedDescription)")
            
        }
        
    

        
        
        
        self.navigationController?.navigationBar.translucent = false
        self.title = "记事本"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true
        
        
        tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addAction:"))
        self.navigationItem.rightBarButtonItem = addItem
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addAction(barItem : UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "提示", message: "是否添加", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "保存", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            
            let textStr = alertController.textFields![0]
            
            
            
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDel.managedObjectContext
            
            let logInEntity = NSEntityDescription.entityForName("LogIn", inManagedObjectContext: context)
            let logModel = NSManagedObject(entity: logInEntity!, insertIntoManagedObjectContext:context) as! LogIn
            
            logModel.notes?.content = textStr.text!
            
            
            do {
                try context.save()
               
                self.dataSources.addObject(textStr.text!)
                
                self.tableView.reloadData()
            }
            catch
            {
                
            }
            
            
            
        }))
        alertController.addTextFieldWithConfigurationHandler { (textFild :UITextField) -> Void in
            
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        cell.textLabel?.text =  dataSources[indexPath.row] as? String
        
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

