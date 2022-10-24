//
//  RegisterViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/19.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    //WebServer的網址，localhost要是數字型態
    let URL_USER_REGISTER = "http://127.0.0.1:8080/LoginDemo/v1/register.php"

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var messageLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // 處理可以重新創建的資源
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //註冊
    @IBAction func registerButton(_ sender: Any) {
        // 發佈請求的參數
        let parameters: Parameters = [
            "username":usernameTextField.text!,
            "password":passwordTextField.text!,
            "name": nameTextField.text!,
            "email": emailTextField.text!,
            "phone": phoneTextField.text!
        ]
        // 發佈請求http post
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON { [self]
            response in
            print(response)
            
            //從WebServer取得json值
            if let result = response.result.value{
                //將其轉為 NSDictionary
                let jsonData = result as! NSDictionary
                
                //在標籤中顯示消息
                self.messageLable.text = jsonData.value(forKey: "message") as! String?
            }
            usernameTextField.text = ""
            passwordTextField.text = ""
            nameTextField.text = ""
            emailTextField.text = ""
            phoneTextField.text = ""
        }
    }
    
    
    @IBAction func backLoginButton(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        self.dismiss(animated: false, completion: nil)
        
    }
}
