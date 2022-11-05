//
//  TsearchResultableViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/26.
//

import UIKit

class TsearchResultableViewController: UITableViewController {
    var getDatas = [getData]()
    var dataText: String! {
        didSet {
            getDatas.insert(getData(getId: dataText), at: 0)
            print("送到陣列裡1\(getDatas)")
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDatas.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TsearchResulTableViewCell.self)", for: indexPath) as! TsearchResulTableViewCell
        let id = getDatas[indexPath.row]
        cell.studentIdLabel.text = id.getId
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "showDetail"){
            if tableView.indexPathForSelectedRow != nil{
                let indexPath = self.tableView.indexPathForSelectedRow
                let tableViewDetail = segue.destination as? TRDetialViewController
                let selectedShape = getDatas[indexPath!.row]
                tableViewDetail?.selectedShape = selectedShape
                self.tableView.deselectRow(at: indexPath!, animated: true)
            }
        }
    }
}
