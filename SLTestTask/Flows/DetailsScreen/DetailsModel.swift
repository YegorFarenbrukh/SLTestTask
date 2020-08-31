//
//  DetailsModel.swift
//  SLTestTask
//
//  Created by apple on 8/30/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import Foundation

struct DetailsModel: Decodable {
    var title: String
    var overview: String
    var poster_path: String
    var release_date: String
    var genres: [Genres]
}

struct Genres: Decodable {
    var name: String
}
