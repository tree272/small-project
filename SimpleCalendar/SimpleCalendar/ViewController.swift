//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by tree on 2021/5/19.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var calenderView: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var numberOfDaysInThisMonth: Int{
        let dateComponent = DateComponents(year: currentYear, month: currentMonth)
        let date = Calendar.current.date(from: dateComponent)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    var whatDayIsIt: Int{
        let dateComponent = DateComponents(year: currentYear, month: currentMonth)
        let date = Calendar.current.date(from: dateComponent)!
        return Calendar.current.component(.weekday, from: date)
    }
    var emptyItemCount: Int{
        return whatDayIsIt - 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
    }

    func setUP()  {
        timeLabel.text = months[currentMonth-1] + " \(currentYear)"
        calenderView.reloadData()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = indexPath.row + 1 - emptyItemCount
        let tmp = DateModel(year: currentYear, month: currentMonth, day: day)
        let detailVC = DetailViewController(model: tmp)
        //navigationController?.pushViewController(detailVC, animated: true)
        present(detailVC, animated: true, completion: nil)
        print("go to DetailViewController!")
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + emptyItemCount
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        if let textLabel = cell.contentView.subviews[0] as? UILabel {
            
            if indexPath.row < emptyItemCount {
                textLabel.text = ""
            }
            else{
                textLabel.text = "\(indexPath.row + 1 - emptyItemCount)"
            }
            
        }
        
        return cell
    }
    
    //上下cell的間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //左右cell的間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7.0
        
        return CGSize(width: width, height: 40)
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.collectionViewLayout.invalidateLayout()
    }
    
    
    //MARK: - Button action
    
    @IBAction func nextMonth(_ sender: UIButton) {
        currentMonth += 1
        if currentMonth == 13 {
            currentMonth = 1
            currentYear += 1
        }
        setUP()
    }
    @IBAction func lastMonth(_ sender: UIButton) {
        currentMonth -= 1
        if currentMonth == 0 {
            currentMonth = 12
            currentYear -= 1
        }
        setUP()
        
    }
    
}

