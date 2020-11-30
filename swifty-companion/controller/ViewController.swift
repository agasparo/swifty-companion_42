//
//  ViewController.swift
//  swifty-companion
//
//  Created by arthur on 28/10/2020.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchDiv: UIView!
    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    var validToken = false
    let Errors = Errors_gesture()
    let ApiCall = Api.sharedInstance
    let HistoData = HistoContent()
    let FavoriteContent = Favorite()
    var FavAllGet: Bool = false
    let TokenGesture = TokeGest()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.FavAllGet == false {
            self.FavAllGet = true
            FavoriteContent.getFav()
        }
        
        if userLogin != nil {
        
            userLogin.delegate = self
            
            if !self.validToken {
                ApiCall.setParent(cl: self)
                ApiCall.launchAuth2()
            }
            
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgHome")!)
            
            searchDiv.layer.shadowColor = UIColor.lightGray.cgColor
            searchDiv.layer.shadowOpacity = 1
            searchDiv.layer.shadowOffset = .zero
            searchDiv.layer.shadowRadius = 10
            searchDiv.layer.cornerRadius = 5
        
            searchBtn.layer.cornerRadius = 5
            searchBtn.layer.borderWidth = 1;
            searchBtn.layer.borderColor = UIColor.lightGray.cgColor
            searchBtn.setTitleColor(.lightGray, for: .normal)
        
            userLogin.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func getApiResponse(code : String) {
        
        if code != "" {
            self.validToken = true
        }
    }
    
    func setHistoAutoCompletion(username: String) {
        
        userLogin.text = username
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            searchBtn.sendActions(for: UIControl.Event.touchUpInside)
        }
    }
    
    func show_userinfos(data: User_gesture) {
        
        userLogin.text = ""
        if (data.login == nil) {
            return;
        }
        HistoData.addContent(user: data.login!)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let infosCV = storyBoard.instantiateViewController(identifier: "SecondVC") as? InfosViewController {
            
            infosCV.fav = self.FavoriteContent
            infosCV.infoObject = data
            self.present(infosCV, animated: true, completion: nil)
        }
    }
    
    func user_not_found() {
        
        userLogin.text = ""
        self.present(Errors.handle_error(name: "Erreur" , error: "Ce login n'existe pas", btn_msg: "ok"), animated: true, completion: nil)
    }
    
    @IBAction func SearchLogin(_ sender: Any) {
        
        let username:String = userLogin.text!
        
        if username.isEmpty {
            
            self.present(Errors.handle_error(name: "Erreur" , error: "Le login ne peut etre vide", btn_msg: "ok"), animated: true, completion: nil)
            return
        }
        
        if self.validToken == true {
            
            let token_infos = ApiCall.token_infos
                
            if TokenGesture.IsTokenOut(content: token_infos!) == true {
                    
                ApiCall.request_api_token()
                self.present(Errors.handle_error(name: "Erreur" , error: "Le token n'est plus valide, nous en regenerons un ...", btn_msg: "ok"), animated: true, completion: nil)
                return
            }
            
            if !ApiCall.request_user(token: token_infos!.access_token, user_name: username) {
                self.show_userinfos(data: ApiCall.user_infos!)
            } else {
                self.user_not_found()
            }
            
        } else {
            
            self.present(Errors.handle_error(name: "Erreur", error: "Aucun token api recu, réessaye plus tard", btn_msg: "ok"), animated: true, completion: nil)
            return
        }
    }

    @IBAction func show_histo(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let histo = storyBoard.instantiateViewController(identifier: "HistoVC") as? HistoCViewController {
            
            histo.kh = HistoData
            histo.auto = self
            self.present(histo, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func show_fav(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let favVc = storyBoard.instantiateViewController(identifier: "FavVC") as? FavViewController {
            
            favVc.infoObject = self.FavoriteContent
            favVc.infoParent = self
            self.present(favVc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
