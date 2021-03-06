//
//  ViewController.swift
//  TableView
//
//  Created by 서민재 on 2022/01/26.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    var dataArray = JSON()
    var tableViewCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let path = Bundle.main.path(forResource: "mock", ofType: "json") else {
            return
        }
        guard let jsonString = try? String(contentsOfFile: path) else {
            return
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data, let result = try?decoder.decode(JSON.self, from: data){
            self.dataArray = result
            self.tableViewCount = self.dataArray.count
            print(self.dataArray)
        }
        self.mainTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.mainTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCount + 1
    }
    
    func setAdata(value : String, title: String, result: JSON) -> String{
        "\(title) : \(result["a"]["\(value)"].stringValue)"
    }
    
//    func setBdata(value : String, title: String, result: JSON) -> String{
//        "\(title) : \(result["b"]["\(value)"].stringValue)"
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell{
                cell.countLabel.text = "Total Count : \(self.dataArray.count)"
                cell.priceLabel.text = "Total Price : \(self.dataArray[0]["price"].doubleValue + self.dataArray[1]["price"].doubleValue + self.dataArray[2]["price"].doubleValue)"
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell{
                let Latitude = "latitude"
                let Longitude = "longitude"
                let Aqi = "aqi"
                let Name = "name"
                
                let result = self.dataArray[indexPath.row - 1]
                
                cell.aLati.text = setAdata(value: Latitude, title: "위도", result: result)
                cell.aLong.text = setAdata(value: Longitude, title: "경도", result: result)
                cell.aAqi.text = setAdata(value: Aqi, title: "공기 퀄리티", result: result)
                cell.aAddress.text = setAdata(value: Name, title: "위치 정보", result: result)
                
                cell.bLati.text = "위도 : \(result["b"]["latitude"].stringValue)"
                cell.bLong.text = "경도 : \(result["b"]["longitude"].stringValue)"
                cell.bAqi.text = "공기 퀄리티 : \(result["b"]["aqi"].stringValue)"
                cell.bAddress.text = "위치 정보 : \(result["b"]["name"].stringValue)"
                
                cell.priceLabel.text = "Price : \(self.dataArray[(indexPath.row) - 1]["price"].stringValue)"
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }else{
            return 300
        }
    }
}



