//
//  Link.swift
//  UI-404
//
//  Created by nyannyan0328 on 2021/12/27.
//

import SwiftUI

struct Link: Identifiable {
    
    var id = UUID().uuidString
    var title : String
    var logo : String
}
var links = [

    Link(title: "Tumblr", logo: "tumblr"),
    Link(title: "Twitter", logo: "twitter"),
    Link(title: "Instagram", logo: "instagram"),
    Link(title: "Google", logo: "google"),
    Link(title: "Dribbble", logo: "dribbble"),
    Link(title: "Pinterest", logo: "pinterest"),
]
