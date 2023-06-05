//
//  StringUtils.swift
//  OneStep
//
//  Created by Yang Jianqi on 2023/5/25.
//

import Foundation

extension String {
  var isEmptyOrWhitespace: Bool {
    return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }
}
