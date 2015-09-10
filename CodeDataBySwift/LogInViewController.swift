//
//  LogInViewController.swift
//  CodeDataBySwift
//
//  Created by 徐继垚 on 15/9/9.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit
import CoreData
class LogInViewController: UIViewController {

    var dataArr = [LogIn]()
    
    @IBOutlet weak var louserName: UITextField!
    @IBOutlet weak var lopassword: UITextField!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appdelegaet = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appdelegaet?.managedObjectContext
        let request  = NSFetchRequest(entityName: "LogIn")
     
        do {
            let fetchResults = try context!.executeFetchRequest(request) as? [LogIn]
         
            self.dataArr = fetchResults!
          
            
        } catch let fetchError as NSError {
            print("获取用户名错误: \(fetchError.localizedDescription)")
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登陆"
        
        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func logInAction(sender: UIButton) {
        
        if (louserName.text == "" || lopassword.text == "") {
            print("不能为空")
            return
        }else
        {
            
            for result in dataArr {
                
                print(result.user)
                if result.user == louserName.text {
                    if result.password  == lopassword.text {
                        let tableVC = ViewController()
                        
                        
                        self.navigationController?.pushViewController(tableVC, animated: true)
                    }
                    else
                    {
                        print("密码错误")
                        return
                    }
                    
                }
                
                
            }
            
            
            
        }
        
        
        
        
      
        
        
        
    }
    @IBAction func reristerAction(sender: UIButton) {
        
        
        let retisterVC  = ReristerViewController()
        
        self.navigationController?.pushViewController(retisterVC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
