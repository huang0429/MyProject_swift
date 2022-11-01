//
//  TRDetialViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/31.
//

import UIKit

class TRDetialViewController: UIViewController {

    var studentItem = [newtPageData]()
    var getDatas = [getData]()
    var dataText: String!
    var selectedShape: getData!
    
    @IBOutlet weak var TRidLabel: UILabel!
    
    @IBOutlet weak var nameDetialLbl: UILabel!
    @IBOutlet weak var depDetialLbl: UILabel!
    @IBOutlet weak var gradeDetialLbl: UILabel!
    @IBOutlet weak var classDetialLbl: UILabel!
    @IBOutlet weak var ssDetialLbl: UILabel!
    @IBOutlet weak var qrcodeDetialLbl: UILabel!
    @IBOutlet weak var transDetialLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TRidLabel.text = selectedShape.getId
        dataItem()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func dataItem(){
        if let urlStr = "http://192.168.121.113:8888/myProject/v1/getNextPageData.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){ [self]
                (data, response, error) in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.studentItem = try decoder.decode([newtPageData].self, from: data)
                        let judge = studentItem
                        let id = judge.map{$0.studentID}
                        print("有到這嗎？3")
                        for studentid in id {
                            
                            if studentid == selectedShape.getId {
                                
                                let studentData = judge[Int(selectedShape.getId)!-1]
                                DispatchQueue.main.async {
                                    self.nameDetialLbl.text = studentData.studentName
                                    self.depDetialLbl.text = studentData.studentDepartment
                                    self.gradeDetialLbl.text = studentData.studentGrade
                                    self.classDetialLbl.text = studentData.studentClass
                                    self.ssDetialLbl.text = studentData.studentStatus
                                    self.qrcodeDetialLbl.text = studentData.studentQRcode
                                    self.transDetialLbl.text = studentData.studentTransportation
                                    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
