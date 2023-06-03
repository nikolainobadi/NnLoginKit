//
//  View+Extensions.swift
//  
//
//  Created by Nikolai Nobadi on 5/28/23.
//

import SwiftUI

// MARK: - Screen Size
internal extension View {
    var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /// Percent required in parameter is direct representation. Example: 1% of width = getWidthPercent(1). 10% of width = getWidthPercent(10)
    func getWidthPercent(_ percent: CGFloat) -> CGFloat { screenWidth * (percent * 0.01) }
    
    /// Percent required in parameter is direct representation. Example: 1% of height = getHeightPercent(1). 10% of height = getHeightPercent(10)
    func getHeightPercent(_ percent: CGFloat) -> CGFloat { screenHeight * (percent * 0.01) }
}
