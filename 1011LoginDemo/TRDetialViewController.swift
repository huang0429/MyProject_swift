//
//  TRDetialViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/31.
//

import UIKit

class TRDetialViewController: UIViewController {

    var getDatas = [getData]()
    var dataText: String!
    
    var selectedShape: getData!
    
    @IBOutlet weak var TRidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TRidLabel.text = selectedShape.getId
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
