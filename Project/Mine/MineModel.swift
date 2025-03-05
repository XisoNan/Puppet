//
//  MineModel.swift
//  Project
//
//  Created by 1234 on 2024/2/8.
//

import Foundation
import HandyJSON

struct MineModel:HandyJSON{
    var name:String="";
    var age:Int=0;
    var headerImg:String=""
    var sex:String=""
}

public enum editType{
    case sex
    case age
}
