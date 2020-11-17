//
//  BigImgViewController.swift
//  SheetDBwithGAS
//
//  Created by MyMBP on 2020/11/15.
//

import UIKit

class BigImgViewController: UIViewController {
    @IBOutlet weak var labelBigName: UILabel!
    @IBOutlet weak var imgBigimage: UIImageView!
    
    var apiData: APIData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelBigName.text = apiData?.name
        if let urlAvatar = URL(string: apiData!.avatar){
            URLSession.shared.dataTask(with: urlAvatar) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imgBigimage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        // Do any additional setup after loading the view.
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
