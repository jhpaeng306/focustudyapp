//
//  UIViewExtension.swift
//  Focustudy
//
//  Created by Jinhee Paeng on 2020/09/24.
//

import UIKit

extension UIView {
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    
    set {
      layer.cornerRadius = newValue
    }
  }
}
