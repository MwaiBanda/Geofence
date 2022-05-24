//
//  BasePlainExpandableCard.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/4/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct BasePlainExpandableCard<
    CoverContent: View,
    CoverIcon: View,
    InnerContent: View
>: View {
    var contentHeight: CGFloat
    var isExpanded: Binding<Bool>
    var coverContent: () -> (CoverContent)
    var coverIcon: (Binding<Bool>) -> (CoverIcon)
    var innerContent: () -> (InnerContent)
    var onCoverClick: () -> Void
var body: some View {
    ZStack(alignment: .top) {
        ZStack {
            if isExpanded.wrappedValue {
                VStack {
                    ScrollView {
                        innerContent()
                            .padding(.top)
                            .padding(.top, 5)
                    }
                }
                .padding(.top, isExpanded.wrappedValue ? 55 : 0)
            }
        }
        .frame(maxWidth: .infinity,  minHeight:isExpanded.wrappedValue ? contentHeight : 0,alignment: .bottom)
        ZStack {
            VStack {
                Divider()
                Spacer()
                HStack(alignment: .center) {
                    coverContent()
                    Spacer()
                    HStack(spacing: 0) {
                        Button {
                            withAnimation(.easeInOut(duration: 0.35)){
                                onCoverClick()
                            }
                        } label: {
                            coverIcon(isExpanded)
                        }
                    }
                }
                .padding()
                .padding(.horizontal)
                if isExpanded.wrappedValue {
                    Divider()
                        .padding(.top, 8)
                }
            }.background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 55, alignment: .top)
        .onTapGesture {
            withAnimation(.easeInOut) {
                onCoverClick()
            }
        }
    }
    .frame(maxWidth: .infinity, alignment: .top)
    .padding(.top, 20)
}
}



