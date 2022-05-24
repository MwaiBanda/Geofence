//
//  PlainExpandableCard.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/4/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct PlainExpandableCard<
    CoverContent: View,
    CoverIcon: View,
    InnerContent: View
>: View {
    init(
        contentHeight: CGFloat = 200,
        coverContent: @escaping () -> (CoverContent),
        coverIcon: @escaping (Binding<Bool>) -> (CoverIcon),
        innerContent: @escaping () -> (InnerContent),
        onCoverClick: @escaping () -> Void = {}

    ) {
        self.contentHeight = contentHeight
        self.coverContent = coverContent
        self.coverIcon = coverIcon
        self.innerContent = innerContent
        self.onCoverClick = onCoverClick
    }
    
    @State private var isExpanded = false
    var contentHeight: CGFloat
    var coverContent: () -> (CoverContent)
    var coverIcon: (Binding<Bool>) -> (CoverIcon)
    var innerContent: () -> (InnerContent)
    var onCoverClick: () -> Void
    var body: some View {
        BasePlainExpandableCard(contentHeight: contentHeight, isExpanded: $isExpanded, coverContent: coverContent, coverIcon: coverIcon, innerContent: innerContent, onCoverClick: {
            isExpanded.toggle()
            if isExpanded {
                onCoverClick()
            }
        })
    }
}
