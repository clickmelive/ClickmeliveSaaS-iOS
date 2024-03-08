//
//  GraphQLNullable+Extensions.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import ApolloAPI

extension GraphQLNullable {
  init(optionalValue value: Wrapped?) {
    if let value {
      self = .some(value)
    } else {
      self = nil
    }
  }
}
