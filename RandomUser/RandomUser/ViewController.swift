//
//  ViewController.swift
//  RandomUser
//
//  Created by tree on 2021/5/10.
//

import UIKit

struct User {
    var  name: String?
    var  email: String?
    var  number: String?
    var  image: String?
}


class ViewController: UIViewController {

    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var infoTableViewController: InfoTableViewController?
    let apiAddress = "https://randomuser.me/api/"
    var urlSession = URLSession(configuration: .default)
    var isDownloading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let aUser = User(name: "Iris", email: "iris@mail.com", number: "8888-1111", image: "http://picture.me")
        settingInfo(user: aUser)
        downloadInfo(withAdderss: apiAddress)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo"{
            infoTableViewController = segue.destination as? InfoTableViewController
        }
    }
    
    func popAlert (withTitle title: String){
        let alert = UIAlertController(title: title, message: "please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "oK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        isDownloading = false
    }
    
    func downloadInfo(withAdderss webAdderss: String) {
        if let url = URL(string: webAdderss){
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                //讀取資料失敗處理
                if error != nil{
                    let errorCode = (error! as NSError).code
                    if errorCode == -1009 {
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "沒有網路")
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "發生不明問題")
                        }
                    }
                    return
                }
                //成功讀取資料
                if let loadData = data{
                    print("got data")
                    do{
                        let jsonData = try JSONDecoder().decode(AllData.self, from: loadData)
                        
                        
                        let firstName = jsonData.results?[0].name?.first
                        let lastName = jsonData.results?[0].name?.last
                        let fullName: String? = {
                            guard let okFirstName = firstName, let okLastName = lastName else{ return nil }
                            
                            return okFirstName + " " + okLastName
                        }()

                        let email = jsonData.results?[0].email
                        let phone = jsonData.results?[0].phone
                        let image = jsonData.results?[0].picture?.large
                          
                        DispatchQueue.main.async {
                            self.settingInfo(user: User(name: fullName, email: email, number: phone, image: image))
                        }
                    }catch{
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "Sorry")
                        }
                    }
                }else{
                    self.isDownloading = false
                }
            }
            task.resume()
            isDownloading = true
        }
        else{
            isDownloading = false
        }
        
        
    }
    
    
//    func parseJson(json: Any){
//        //要取出來的位置是個dictionary
//        if let okJson = json as? [String:Any]{
//            //用key"result"取出來的值是dictionary的array
//            if let infoArray = okJson["results"] as? [[String:Any]]{
//                let infoDictionary = infoArray[0]
//                let loadedName = userFullName(nameDictionary: infoDictionary["name"])
//                let loadedEmail = infoDictionary["email"] as? String
//                let loadedPhone = infoDictionary["phone"] as? String
//                let imageDictionary = infoDictionary["image"] as? [String:String]
//                let loadedImage = imageDictionary?["large"] //imageDictionary是optional dictionary
//                let user = User(name: loadedName, email: loadedEmail, number: loadedPhone, image: loadedImage)
//                settingInfo(user: user)
//            }
//        }
//    }

    func userFullName(nameDictionary: Any?) -> String? {
        //轉type，已知key"name"中的value都是String
        if let okDictionary = nameDictionary as? [String:String]{
            let firstName = okDictionary["first"] ?? ""
            let lastName = okDictionary["last"] ?? ""
            return firstName + " " + lastName
        }else{
            return nil
        }
    }
    
    func  settingInfo(user: User){
        userLabel.text = user.name
        infoTableViewController?.phoneLabel.text = user.number
        infoTableViewController?.emailLabel.text = user.email
        if let imageAddress = user.image{
            if let imageUrl = URL(string: imageAddress){
               let task =  urlSession.downloadTask(with: imageUrl) { (url, response, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            self.popAlert(withTitle: "Sorry")
                        }
                        return
                    }
                    if let okUrl = url{
                        do {
                            let downloadImage = UIImage(data: try Data(contentsOf: okUrl))
                            print(okUrl)
                            DispatchQueue.main.async {
                                self.userImage.image = downloadImage
                            }
                            self.isDownloading = false
                        }catch{
                            DispatchQueue.main.async {
                                self.popAlert(withTitle: "SORRY")
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
    }

    @IBAction func makeNewUser(_ sender: UIBarButtonItem) {
        if isDownloading == false {
            downloadInfo(withAdderss: apiAddress)
        }
        
        
    }
    
    
    
}

