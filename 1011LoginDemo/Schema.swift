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
}

struct newtPageData: Codable{
    var studentName: String
    var studentDepartment: String
    var studentGrade: String
    var studentClass: String
    var studentStatus: String
    var studentQRcode: String
    var studentTransportation: String
}
