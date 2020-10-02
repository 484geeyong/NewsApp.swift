//
//  ViewController.swift
//  newsProject
//
//  Created by 484 on 02/10/2020.
//  Copyright © 2020 484geeyong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var TableViewMain: UITableView!
    var newsData :Array<Dictionary<String, Any>>?
    func getNews(){
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=a7a425d1c83e4effbc32b2a36a50936f")!) { (data, response, error) in
            if let dataJson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any> //강제로 Dictionary로 변환
                    
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>//Dictionary에서 키값이 articles인 부분 찾기
//                    print(articles)
                    self.newsData = articles
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                    
//                    for(idx, value) in articles.enumerated(){
//                        if let v = value as? Dictionary<String, Any>{
//                            print("\(v["title"])")
//                        }//안에 타이틀 찾기..
//                    }
//
                }
                catch{}
            }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //데이터 몇개
        if let news = newsData{
            return news.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //데이터가 무엇
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        let idx = indexPath.row
        
        if let news = newsData{
            let row = news[idx]
            if let r = row as? Dictionary<String, Any>{
                if let title = r["title"] as? String{
                     cell.LabelText.text = title
                }
               
            }
            
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click\(indexPath.row)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        getNews()
    }
    


}

