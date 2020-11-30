//
//  user.swift
//  swifty-companion
//
//  Created by arthur on 29/10/2020.
//

import Foundation

struct User_gesture: Codable {
    
    var correction_point, wallet: Int?
    var email, login, phone, displayname, image_url, pool_month, pool_year, url: String?
    var cursus_users: [User_cursus_gesture]?
    var projects_users: [User_project_gesture]?
    var achievements: [User_achievements_gesture]?
    
}

struct User_cursus_gesture: Codable {
    
    var grade: String?
    var level: Float?
    var skills: [User_skill_gesture]
    var cursus: User_cursus_type?
    var begin_at: String?
    var end_at: String?
}

struct User_cursus_type: Codable {
    
    var id: Int?
    var name: String?
}

struct User_skill_gesture: Codable {
    
    var name: String?
    var level: Float?
}

struct User_project_gesture: Codable {
    
    var final_mark, occurrence: Int?
    var status: String?
    var project: User_project_details_gesture?
    var cursus_ids: [Int]?
    var marked_at: String?
}

struct User_project_details_gesture: Codable {
    
    var name: String?
}

struct User_achievements_gesture: Codable {
    
    var name, description:String?
}
