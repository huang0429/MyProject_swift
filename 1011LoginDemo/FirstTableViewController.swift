//
//  FirstTableViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/18.
//

import UIKit
import Foundation

class FirstTableViewController: UITableViewController {
    
    var newsItem = [newsSchema]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
        fetchItems()
    }
    //http://192.168.1.112:8080/myProject/v1/getnews.php    blu3387
    //http://192.168.239.113:8080/myProject/v1/getnews.php  note20
    func fetchItems(){
        if let urlStr = "http://192.168.90.113:8888/myProject/v1/getnews.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){ [self]
                (data, response, error) in
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        self.newsItem = try decoder.decode([newsSchema].self, from: data)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
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
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItem.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"\(FirstTableViewCell.self)" , for: indexPath) as? FirstTableViewCell
        let news = newsItem[indexPath.row]
        cell!.labelNewsID!.text = news.news_ID
        cell!.labelNewsTitle.text = news.news_title
        cell!.labelNewsDate.text = news.news_date

        return cell!
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
