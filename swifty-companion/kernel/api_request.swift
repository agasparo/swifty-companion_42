//
//  api_request.swift
//  swifty-companion
//
//  Created by arthur on 28/10/2020.
//

import Foundation
import SwiftUI

class Api {
    
    var token_infos: Token_gesture?
    var user_infos: User_gesture?
    var api_config: Api_manage = Api_manage()
    var Parent: ViewController?
    
    static let sharedInstance = Api()
    
    func setParent(cl: ViewController) {
        
        self.Parent = cl
    }
    
    func get_token() -> Token_gesture {

        return (self.token_infos!)
    }
    
    func launchAuth2() {
        
        let url = "https://api.intra.42.fr/oauth/authorize?client_id="+self.api_config.uid+"&redirect_uri=swiftyCompanion://test&response_type=code"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
    
    func getAuth2Token(code: String) {
        
        self.request_api_token()
        self.Parent?.getApiResponse(code: code)
    }
    
    func request_api_token() {
     
        let params = "grant_type=client_credentials&client_id="+self.api_config.uid+"&client_secret="+self.api_config.secret
        
        let target = URL(string: self.api_config.endpoint + "/oauth/token")!
        
        var request = URLRequest(url: target)
        request.httpMethod = "POST"
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, _) in
            if let data = data {
                if let dataString = String(data: data, encoding: String.Encoding.utf8) {
                    do {
                        let jsonData = dataString.data(using: .utf8)!
                        self.token_infos = try JSONDecoder().decode(Token_gesture.self, from: jsonData)
                        if (self.token_infos!.created_at < Int(NSDate().timeIntervalSince1970)) {
                            self.token_infos?.created_at = Int(NSDate().timeIntervalSince1970)
                        }
                    } catch {
                        return
                    }
                }
            }
        }.resume()
    }
    
    func request_user(token: String, user_name: String) -> Bool {
        
        let target = URL(string: self.api_config.endpoint + "/v2/users/" + user_name)!
        
        var request = URLRequest(url: target)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let semaphore = DispatchSemaphore(value: 0)
        var result: Bool = false;
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, _) in
            if let data = data {
                if let dataString = String(data: data, encoding: String.Encoding.utf8) {
                    do {
                        let jsonData = dataString.data(using: .utf8)!
                        self.user_infos = try JSONDecoder().decode(User_gesture.self, from: jsonData)
                        semaphore.signal()
                        return
                    } catch {
                        result = true
                        semaphore.signal()
                        return
                    }
                }
            }
        }.resume()
        
        semaphore.wait()
        
        return result
    }
}
