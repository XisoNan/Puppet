//
//  All.swift
//  Project
//
//  Created by 1234 on 2024/3/10.
//

import Foundation
import UIKit
import SwiftyJSON
import HandyJSON
import Hero

public func archivImage(image: UIImage, type: String) -> String {
    if let imageData = image.jpegData(compressionQuality: 400) as NSData? {
        let fullPath = NSHomeDirectory().appending("/Documents/").appending(type)
        imageData.write(toFile: fullPath, atomically: true)
        return fullPath
    }
    return ""
}


func ButtonAnimate(_ sender: UIImageView){
    UIView.animate(withDuration: 0.25, animations: {
        sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }) { (finished) in
        UIView.animate(withDuration: 0.25) {
            sender.transform = CGAffineTransform.identity
        }
    }
}
//计算label宽度
func calculateLabelWidth(text: String, font: UIFont) -> CGFloat {
    let attributes = [NSAttributedString.Key.font: font]
    let size = (text as NSString).size(withAttributes: attributes)
    return size.width
}


var isFsh:[String:Bool]=["提线_left":false,"提线_right":false,"布袋_left":false,"布袋_right":false,"杖头_left":false,"杖头_right":false,"铁枝_left":false,"铁枝_right":false,]

let widfit=Width/1024
let heifit=Height/1800


func captureScreenshot(vc: UIViewController) -> UIImage? {
    // 创建一个与当前屏幕尺寸相同的图形上下文
    let format = UIGraphicsImageRendererFormat()
    format.scale = UIScreen.main.scale
    let renderer = UIGraphicsImageRenderer(size: UIScreen.main.bounds.size, format: format)
    
    // 在图形上下文中绘制当前页面内容
    let image = renderer.image { context in
        let currentView = vc.view!
        currentView.drawHierarchy(in: currentView.bounds, afterScreenUpdates: true)
    }
    return image
}

 let YU=["命运掌握在自己手中。","使人成为绅士的是干净衣服。","人生如梦，珍惜当下。","灵活应变，方能立足。","故事不灭，药发永存。"]

//获取当天日
let calendar=Calendar.current
let now=Date()
let day=calendar.component(.day, from: now)
let rdm=day%5


func ChangeText(old:String)->String{
    var newstr=""
    for newchr in old{
        newstr.append(newchr)
        newstr.append("\n")
    }
    return newstr
}
