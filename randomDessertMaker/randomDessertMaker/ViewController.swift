//
//  ViewController.swift
//  randomDessertMaker
//
//
//

import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
        CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var dessertImage: UIImageView!
    @IBOutlet weak var dessertTypeLAbel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var jamLabel: UILabel!
    @IBOutlet weak var creamLabel: UILabel!
    
    
    var myDessert = dessertType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func changeLabel(_ label:UILabel, withString string:String) {
        label.text = "-"
        label.fadeTransition(0.5)
        label.text = string
        
    }
    
    
    
    func changeImage(_ imageName: String) {
        dessertImage.image = UIImage(named: imageName) ?? UIImage(systemName: "questionmark.square.dashed")
        dessertImage.fadeTransition(0.5)
    }
    
    @IBAction func makeNewDessert(_ sender: UIButton) {
        
        
        let dessertInfo = myDessert.makeADessert()
        let dessertName = dessertInfo[0].split(separator: "-")
        changeImage(String(dessertName[0]))
        
        changeLabel(self.dessertTypeLAbel, withString: dessertInfo[0])
        changeLabel(self.ingredientsLabel, withString: dessertInfo[1])
        changeLabel(self.jamLabel, withString: dessertInfo[2])
        changeLabel(self.creamLabel, withString: dessertInfo[3])
 
    }

}

