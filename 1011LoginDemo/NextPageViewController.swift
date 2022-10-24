//
//  NextPageViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/21.
//

import UIKit


class NextPageViewController: UIViewController {
    
    var studentItem = [newtPageData]()
    
    let URL_USER_LOGIN = "http://192.168.239.113:8080/LoginDemo/v1/getNextPageData.php"

    @IBOutlet weak var nextPageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var studentStatusLabel: UILabel!
    @IBOutlet weak var qrcodeLabel: UILabel!
    @IBOutlet weak var transportationLabel: UILabel!
    
    var dataText: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageLabel.text = dataText
        
        fetchItems()
        
    }
    
    @IBAction func clossesButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func fetchItems(){
        if let urlStr = URL_USER_LOGIN.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){ [self]
                (data, response, error) in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.studentItem = try decoder.decode([newtPageData].self, from: data)
                        
                        
//
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
                    } catch  {
                        print(error)
                    }
                  
                } else {
                    print("no date")
                }
            }
            task.resume()
        }
    }
    
//    func fetchItems(){
//        // 元件繫結
//        // 取得我要的資料
//        let parameters: Parameters=[
//            "student_name":nameLabel.text!,
//            "department_name":departmentLabel.text!,
//            "grade_level":gradeLabel.text!,
//            "class_name":classLabel.text!,
//            "status_ing":studentStatusLabel.text!,
//            "qrcode_ing":qrcodeLabel.text!,
//            "transportation_name":transportationLabel.text!
//        ]
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
