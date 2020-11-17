//
//  ViewController.swift
//  SheetDBwithGAS
//
//  Created by MyMBP on 2020/11/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    
    let HTTP_METHOD_GET = "GET"
    let CONTENT_TYPE = "application/json"
    let HTTP_HEADER_FIELD = "Content-Type"
    
    var aPIDataArray = [APIData]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        // Do any additional setup after loading the view.
        
        // TableView的隔線只顯示到有資料的部分
        myTableView.tableFooterView = UIView()
    }
    
    func getDataFromSheetDB() {

        let urlSheetDb = "https://sheet"
        let urlGAS = "https://googl"
//        let apiUrl = urlSheetDb
        let apiUrl = urlGAS
        
        if let urlApi = URL(string: apiUrl) {
//            print("urlSheetDB: \(urlSheetDB)")
            var urlRequest = URLRequest(url: urlApi)
            urlRequest.httpMethod = HTTP_METHOD_GET
            urlRequest.setValue(CONTENT_TYPE, forHTTPHeaderField: HTTP_HEADER_FIELD)

            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error == nil {
                    if let data = data,
                       let aPIDataArray = try? JSONDecoder().decode([APIData].self, from: data) {
    //                    print("\(String(data: data, encoding: .utf8))")
                        self.aPIDataArray = aPIDataArray
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                    }
                } else {
                    print("====== getDataFromSheetDB error ======")
                    print("debugDescription: \(error.debugDescription)")
                    print("====== getDataFromSheetDB error =======")
                    self.aPIDataArray = self.getDataFromArray()
                    
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                }
            }.resume()
        }
    } // func getDataFromSheetDB()
    
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromSheetDB()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? BigImgViewController,
           let selectedCell = myTableView.indexPath(for: (sender as? UITableViewCell)!) {
            controller.apiData = aPIDataArray[selectedCell.row]
                    }
    }


}



extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("aPIDataArray.count: \(aPIDataArray.count)")
        return aPIDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "\(MyTableVCell.self)", for: indexPath) as! MyTableVCell
        
        let apiData = aPIDataArray[indexPath.row]
        
        if let urlAvatar = URL(string: apiData.avatar){
            URLSession.shared.dataTask(with: urlAvatar) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imgView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        cell.labelName.text = apiData.name
        cell.labelDrink.text = apiData.drink
        cell.labelIce.text = apiData.ice == 1 ? "冰" : "熱"
        cell.labelSweet.text = String(repeating: "🍬", count: apiData.sweet)
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 16    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.imgView.bounds.origin.x, y: cell.imgView.bounds.origin.y, width: cell.imgView.bounds.width, height: cell.imgView.bounds.height)
        cell.imgView.layer.mask = maskLayer
        
        
//        cell.backgroundColor = UIColor(red: CGFloat(Int.random(in: Int(0.10)...1)), green: CGFloat(Int.random(in: Int(0.10)...1)), blue: CGFloat(Int.random(in: Int(0.10)...1)), alpha: CGFloat(Int.random(in: Int(0.10)...1)))
        return cell
        
    }
    

    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: MyTableVCell?) {
//
//        let control = segue.destination as? BigImgViewController
//        let
//            control?.apiData = aPIDataArray[sender.row]
//
//
//    }
    
}

extension ViewController {
    // Cell 設為圓角，且移除分隔線
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8
        let horizontalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: horizontalPadding, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func getDataFromArray()->[APIData] {
        var apiDatas = [APIData]()
        var apiData = APIData(name: "潘帥", drink: "重烘焙拿鐵", ice: 0, sweet: 5, avatar: "https://user-images.strikinglycdn.com/res/hrscywv4p/image/upload/c_limit,f_auto,h_1440,q_90,w_720/271374/Screen_Shot_2015-12-10_at_12.45.00_AM_tiphgo.jpg")
        apiDatas.append(apiData)
        
        apiData = APIData(name: "布魯斯", drink: "經典美式", ice: 0, sweet: 1, avatar: "https://lh3.googleusercontent.com/ogw/ADGmqu8kc1ZeQI3Fqi9-BIV3WMqAMdekeYkCt-XN-Vo0lQ=s192-c-mo")
        apiDatas.append(apiData)
        
        apiData = APIData(name: "初音未來", drink: "檸檬多多綠", ice: 1, sweet: 4, avatar: "https://upload.wikimedia.org/wikipedia/zh/8/8b/Hatsune_Miku_V4X.jpg")
        apiDatas.append(apiData)
        
        apiData = APIData(name: "巡音流歌", drink: "洛神花茶", ice: 1, sweet: 3, avatar: "https://upload.wikimedia.org/wikipedia/zh/7/7d/Luka_Megurine.png")
        apiDatas.append(apiData)
        
        apiData = APIData(name: "鏡音鈴、連", drink: "珍珠奶茶", ice: 0, sweet: 3, avatar: "https://upload.wikimedia.org/wikipedia/zh/d/da/Kagamine_Rin_and_Len_V4X.png")
        apiDatas.append(apiData)
        
        return apiDatas
    }
}
