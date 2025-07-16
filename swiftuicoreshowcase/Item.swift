//
//  Item.swift
//  swiftuicoreshowcase
//
//  Created by Mengthong on 16/7/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
