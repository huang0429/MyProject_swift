//
//  Schema.swift
//  1011LoginDemo
//
//  Created by 黃筱珮 on 2022/10/19.
//

import Foundation

struct newsSchema: Codable{
    var news_ID: String
    var news_title: String
    var news_date: String
    var news_content: String
}

struct newtPageData: Codable{
    var studentID: String
    var studentName: String
    var studentDepartment: String
    var studentGrade: String
    var studentClass: String
    var studentStatus: String
    var studentQRcode: String
    var studentTransportation: String
    
    enum CodingKeys: String, CodingKey {
            case studentID = "student_ID"
            case studentName = "student_name"
            case studentDepartment = "department_name"
            case studentGrade = "grade_level"
            case studentClass = "class_name"
            case studentStatus = "status_ing"
            case studentQRcode = "qrcode_ing"
            case studentTransportation = "transportation_name"
        }
}

struct getData {
    var getId: String
}

