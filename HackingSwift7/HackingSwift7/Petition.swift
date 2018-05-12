//
//  Petition.swift
//  HackingSwift7
//
//  Created by Franklin Buitron on 5/11/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import Foundation

struct PetitionResponse: Codable {
    var metadata: PetitionMetadata
    var results: [Petition]
}

struct PetitionMetadata: Codable {
    var responseInfo:ResponseInfo
}

struct ResponseInfo: Codable {
    var status: Int
    var developerMessage: String
}

struct Petition: Codable {
    var title: String
    var body: String
    var signatureThreshold: Int
    var signatureCount: Int
    var signaturesNeeded: Int
    var issues: [PetitionIssues]
}

struct PetitionIssues: Codable {
    var id: Int
    var name: String
}
