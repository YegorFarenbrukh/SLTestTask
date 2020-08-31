//
//  String.swift
//  SLTestTask
//
//  Created by apple on 8/27/20.
//  Copyright © 2020 GQt. All rights reserved.
//

extension String {
    
    // MARK: - Trunc func. This function cuts string if there does not fit to labels and make three dots instead of the last word that Label is cut.
    func trunc(length: Int, trailing: String = "…") -> String {
        if (self.count <= length) {
            return self
        }
        var truncated = self.prefix(length)
        while truncated.last != " " {
            truncated = truncated.dropLast()
        }
        return truncated + trailing
    }
}
