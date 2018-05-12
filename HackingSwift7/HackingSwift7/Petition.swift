//
//  Petition.swift
//  HackingSwift7
//
//  Created by Franklin Buitron on 5/11/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureThreshold: Int
    var signatureCount: Int
    var signaturesNeeded: Int
    var issues: [PetitionIssues]
}

struct PetitionIssues: Codable {
    var id: String
    var name: String
}

/**
 "title":"Legal immigrants should get freedom before undocumented immigrants – moral, just and fair",
 "body":"I am petitioning President Trump's Administration to take a humane view of the plight of legal immigrants. Specifically, legal immigrants in Employment Based (EB) category. I believe, such immigrants were short changed in the recently announced reforms via Executive Action (EA), which was otherwise long due and a welcome announcement.",
 "issues":[
 {
 "id":"28",
 "name":"Human Rights"
 },
 {
 "id":"29",
 "name":"Immigration"
 }
 ],
 "signatureThreshold":100000,
 "signatureCount":267,
 "signaturesNeeded":99733,
 },
 **/
