//
//  InfosViewController.swift
//  swifty-companion
//
//  Created by arthur on 28/10/2020.
//

import UIKit

class InfosViewController: UIViewController {
    
    @IBOutlet weak var ViewUserInfos: UIView!
    
    @IBOutlet weak var UserInfos: UIView!
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var DisplayName: UILabel!
    @IBOutlet weak var UserPhone: UILabel!
    @IBOutlet weak var UserMail: UILabel!
    @IBOutlet weak var UserWallou: UILabel!
    @IBOutlet weak var UserPoints: UILabel!
    @IBOutlet weak var UserPoolMonth: UILabel!
    @IBOutlet weak var UserPoolYear: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var TableSkills: UITableView!
    @IBOutlet weak var TableProj: UITableView!
    @IBOutlet weak var TableComp: UITableView!
    
    @IBOutlet weak var FavBtn: UIBarButtonItem!
    
    var data: User_gesture?
    var Skills: UserSkills? = UserSkills()
    var Project: UserProject? = UserProject()
    var Compt: UserComp? = UserComp()
    var Errors: Errors_gesture? = Errors_gesture()
    var FaveContent: Favorite?
    
    var infoObject:User_gesture? {
        didSet {
            data = infoObject!
        }
    }
    
    var fav:Favorite? {
        didSet {
            FaveContent = fav!
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if ((FaveContent?.isFav(username: self.data!.login!)) == true) {
            
            FavBtn.tintColor = UIColor.yellow
        }
        
        self.Skills?.setData(content: self.data!)
        self.Skills?.setParent(cl: self)
        TableSkills.delegate = self.Skills
        TableSkills.dataSource = self.Skills
        
        self.Project?.setData(content: self.data!)
        self.Project?.setGoodDatas()
        self.Project?.setParent(cl: self)
        TableProj.delegate = self.Project
        TableProj.dataSource = self.Project
        
        self.Compt?.setData(content: self.data!)
        self.Compt?.setParent(cl: self)
        TableComp.delegate = self.Compt
        TableComp.dataSource = self.Compt
        
        ScrollView.contentSize.height = ContentView.frame.height + 50
        
        ViewUserInfos.backgroundColor = UIColor(patternImage: UIImage(named: "bgHome")!)
        UserInfos.backgroundColor = UIColor(white: 1, alpha: 0.5)
        TableSkills.layer.cornerRadius = 5
        TableProj.layer.cornerRadius = 5
        TableComp.layer.cornerRadius = 5
        self.setUserInfosBase(data: self.data!)
    }
    
    func setUserInfosBase(data: User_gesture) {
        
        data.displayname == nil ? (DisplayName.text = "none") : (DisplayName.text = data.displayname!)
        data.phone == nil ? (UserPhone.text = UserPhone.text! + " : none") : (UserPhone.text = UserPhone.text! + " : " + data.phone!)
        data.email == nil ? (UserMail.text = UserMail.text! + " : none") : (UserMail.text = UserMail.text! + " : " + data.email!)
        data.pool_year == nil ? (UserPoolYear.text = UserPoolYear.text! + " : none") : (UserPoolYear.text = UserPoolYear.text! + " : " + data.pool_year!)
        data.pool_month == nil ? (UserPoolMonth.text = UserPoolMonth.text! + " : none") : (UserPoolMonth.text = UserPoolMonth.text! + " : " + data.pool_month!)
        data.correction_point == nil ? (UserPoints.text = UserPoints.text! + " : none") : (UserPoints.text = UserPoints.text! + " : " + String(data.correction_point!))
        data.wallet == nil ? (UserWallou.text = UserWallou.text! + " : none") : (UserWallou.text = UserWallou.text! + " : " + String(data.wallet!))
        UserImg.load(url: URL(string: data.image_url!)!)
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareUserProfil(_ sender: Any) {
    
        let someText:String = "Partagez le profil de : " + self.data!.login!
        let objectsToShare:URL = URL(string: "https://profile.intra.42.fr/users/" + self.data!.login!)!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail]

            self.present(activityViewController, animated: true, completion: nil)
    }
    
    func moreInfos(name_infos: String, content: String) {
        
        self.present(Errors!.handle_error(name: name_infos , error: content, btn_msg: "ok"), animated: true, completion: nil)
    }
    
    @IBAction func UpdateFav(_ sender: Any) {
        
        if ((FaveContent?.isFav(username: self.data!.login!)) == false) {
            
            if self.FaveContent?.addFav(username: self.data!.login!) == true  {
                FavBtn.tintColor = UIColor.yellow
            }
        } else {
            if self.FaveContent?.deleteFav(username: self.data!.login!) == true {
                FavBtn.tintColor = UIColor.gray
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
