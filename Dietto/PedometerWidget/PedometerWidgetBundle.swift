//
//  PedometerWidgetBundle.swift
//  PedometerWidget
//
//  Created by 안정흠 on 5/31/25.
//

import WidgetKit
import SwiftUI

@main
struct PedometerWidgetBundle: WidgetBundle {
    var body: some Widget {
        PedometerWidget()
        PedometerWidgetControl()
    }
}
