//
//  NewsContentViewController.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/11/3.
//

import UIKit

class NewsContentViewController: UIViewController {

    var newsItem = [newsSchema]()
    var newsIdData:newsSchema!
    var selected: newsSchema!
    
    @IBOutlet weak var newsIdLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsIdLabel.text = selected.news_ID
        fetchItems()
    }
    func fetchItems(){
        if let urlStr = "http://192.168.121.113:8888/myProject/v1/getnews.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){ [self]
                (data, response, error) in
                
                if let data{
                    let decoder = JSONDecoder()
                    do {
                        self.newsItem = try decoder.decode([newsSchema].self, from: data)
                        let judge = newsItem
                        let id = judge.map{$0.news_ID}
                        print(id)
                        for getNewContent in id {
                            if getNewContent == selected.news_ID {

                                let newsData = judge[Int(selected.news_ID)!-1]

                                DispatchQueue.main.async {
                                    self.newsTitleLabel.text = newsData.news_title
                                    self.dateLabel.text = newsData.news_date
                                    self.contentLabel.text = newsData.news_content
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
