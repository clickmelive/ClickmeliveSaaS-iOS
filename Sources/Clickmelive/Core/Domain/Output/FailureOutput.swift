//
//  FailureOutput.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

protocol FailureOutput {
    func failed(error: Error)
}
