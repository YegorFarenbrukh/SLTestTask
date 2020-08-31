//
//  Films.swift
//  SLTestTask
//
//  Created by apple on 8/27/20.
//  Copyright © 2020 GQt. All rights reserved.
//

struct Films: Decodable {
    var page: Int
    var results: [Results]
}

struct Results: Decodable {
    var id: Int
    var poster_path: String
    var title: String
    var overview: String
}

