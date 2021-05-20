//
//  DetailViewController.swift
//  SimpleCalendar
//
//  Created by tree on 2021/5/19.
//
/*
 純code init練習
 背景顏色預設是透明的
 除了自己實作帶有參數的init，「required init?(coder: NSCoder)」這個也必須寫出來，不過從內容看得出來這個用不到。
 */



import UIKit

struct DateModel {
    var year: Int
    var month: Int
    var day: Int
}


class DetailViewController: UIViewController {

    var date: DateModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 20))
        label.text = "\(date.year) / \(date.month) / \(date.day)"
        label.tintColor = .darkGray
        self.view.addSubview(label)
    }

    
    init(model: DateModel) {
        self.date = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
