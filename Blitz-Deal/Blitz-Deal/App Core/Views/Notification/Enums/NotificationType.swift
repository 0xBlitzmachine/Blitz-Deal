//
//  NotificationType.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 11.03.24.
//

import Foundation
import SwiftUI

enum NotificationType {
    case error, info, success, warning
    
    var color: Color {
        switch self {
        case .error:
            return .red
        case .info:
            return .blue
        case .success:
            return .green
        case .warning:
            return .orange
        }
    }
    
    var title: String {
        switch self {
        case .error:
            return "Something went wrong!"
        case .info:
            return "Information"
        case .success:
            return "Success"
        case .warning:
            return "Warning"
        }
    }
}
