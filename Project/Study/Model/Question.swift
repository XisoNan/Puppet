//
//  Question.swift
//  Quizzier
//
//  Created by liyuehang on 2023/11/14.
//

import Foundation
import UIKit

struct Question {
    var title: String
    var options: [Option]
    var answer: Option
}

struct Option {
    var name: String
    var content: String = ""
}

