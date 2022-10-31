//
//  NextPageViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/21.
//

import UIKit


class NextPageViewController: UIViewController {
    
    var studentItem = [newtPageData]()
    
    var dataText: String!
    
    @IBOutlet weak var nextPageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var studentStatusLabel: UILabel!
    @IBOutlet weak var qrcodeLabel: UILabel!
    @IBOutlet weak var transportationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageLabel.text = dataText

        fetchItems()
        
    }
    
    @IBAction func clossesButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func fetchItems(){
        if let urlStr = "http://192.168.121.113:8888/myProject/v1/getNextPageData.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){ [self]
                (data, response, error) in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.studentItem = try decoder.decode([newtPageData].self, from: data)
                        let judge = studentItem
                        let id = judge.map{$0.studentID}
                        for studentid in id {
                            if studentid == dataText {
                                
                                let studentData = judge[Int(dataText)!-1]
                                
                                DispatchQueue.main.async {
                                    self.nameLabel.text = studentData.studentName
                                    self.departmentLabel.text = studentData.studentDepartment
                                    self.gradeLabel.text = studentData.studentGrade
                                    self.classLabel.text = studentData.studentClass
                                    self.studentStatusLabel.text = studentData.studentStatus
                                    self.qrcodeLabel.text = studentData.studentQRcode
                                    self.transportationLabel.text = studentData.studentTransportation
                                }
                            }
                        }
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
}
