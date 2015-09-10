//
//  ReristerViewController.swift
//  CodeDataBySwift
//
//  Created by 徐继垚 on 15/9/9.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit
import CoreData

class ReristerViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWords: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        
        
        passWords.secureTextEntry = true
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func postImageAction(sender: UIButton) {
        
        let alertViewController = UIAlertController(title: "请选择上传方式", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertViewController.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: nil))
        alertViewController.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
            self.localPhoto()
            
        }))
        alertViewController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alertViewController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func restrisAction(sender: UIButton) {
        
        
        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDel.managedObjectContext
        
        let logInEntity = NSEntityDescription.entityForName("LogIn", inManagedObjectContext: context)
        let logModel = NSManagedObject(entity: logInEntity!, insertIntoManagedObjectContext:context) as! LogIn
        
        if (userName.text != "" && passWords.text != "") {
            
            let request  = NSFetchRequest(entityName: "LogIn")
            
            do {
                let fetchResults = try context.executeFetchRequest(request) as? [LogIn]
                
                for result in fetchResults! {
                    print(result.user)
                    if result.user != userName.text {
                        logModel.user = userName.text
                        logModel.password = passWords.text
                        if photoImageView.image != nil {
                            let data = UIImageJPEGRepresentation(photoImageView.image!, 0)
                            
                            logModel.photo = data
                            
                            
                            do {
                                try context.save()
                                return
                            }
                            catch
                            {
                                
                            }
                            
                            
                        }
                        else
                        {
                            let alertViewController1 = UIAlertController(title: "警告", message: "请上传图片", preferredStyle: UIAlertControllerStyle.Alert)
                            alertViewController1.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
                            self.presentViewController(alertViewController1, animated: true, completion: nil)
                        }
                    }
                    else
                    {
                       
                        let alertViewController2 = UIAlertController(title: "警告", message: "用户名已存在", preferredStyle: UIAlertControllerStyle.Alert)
                        alertViewController2.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
                        self.presentViewController(alertViewController2, animated: true, completion: nil)
                        

                    }
                }
                
                
            } catch let fetchError as NSError {
                print("获取用户名错误: \(fetchError.localizedDescription)")
                
            }

            
        }
        else {
            
            let alertViewController3 = UIAlertController(title: "警告", message: "用户名或密码不能为空", preferredStyle: UIAlertControllerStyle.Alert)
            alertViewController3.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alertViewController3, animated: true, completion: nil)
            

            
        }
        
        
 
        
        
    }
    
    func localPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        photoImageView.image = image
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
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
