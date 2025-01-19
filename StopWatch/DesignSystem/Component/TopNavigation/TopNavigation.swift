//
//  TopNavigation.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public struct TopNavigation: View {
    
    public typealias NavigationItem = (Image, () -> Void)
    
    private let leadingItem: NavigationItem?
    private let leadingButton: (String, () -> Void)?
    
    private let leadingTitle: String?
    private let centerTitle: String?
    
    private let trailingItems: [NavigationItem]
    private let trailingButton: (String, () -> Void)?
    
    
    public init(
        leadingItem: NavigationItem? = .none,
        leadingButton: (String, () -> Void)? = .none,
        leadingTitle: String? = .none,
        centerTitle: String? = .none,
        trailingItems: [NavigationItem] = [],
        trailingButton: (String, () -> Void)? = .none
    ) {
        self.leadingItem = leadingItem
        self.leadingButton = leadingButton
        self.leadingTitle = leadingTitle
        self.centerTitle = centerTitle
        self.trailingItems = trailingItems
        self.trailingButton = trailingButton
    }
    
    
    public var body: some View {
        HStack(spacing: .zero) {
            if let leadingItem {
                navigationItem(leadingItem)
                    .foregroundStyle(Color.getColor(.text_normal))
            }
            if let leadingTitle {
                Text(leadingTitle)
                    .setTypo(.subTitle3)
                    .foregroundStyle(Color.getColor(.text_strong))
            }
            if let leadingButton {
                Button(action: {
                    leadingButton.1()
                }, label: {
                    Text(leadingButton.0)
                        .setTypo(.title3)
                        .foregroundStyle(Color.getColor(.text_strong))
                        .padding(.horizontal, 16)
                })
            }
            
            Spacer()
            if let trailingButton {
                Button(action: {
                    trailingButton.1()
                }, label: {
                    Text(trailingButton.0)
                        .setTypo(.body2)
                        .foregroundStyle(Color.getColor(.text_alternative))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                })
            }
            
            if trailingItems.isNotEmpty {
                ForEach(Array(0..<trailingItems.count), id: \.self) { i in
                    let item = trailingItems[i]
                    navigationItem(item)
                        .foregroundStyle(Color.getColor(.gray_fill_assistive))
                }
            }
        }
        .padding(.horizontal, 4)
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .center) {
            HStack(spacing: 4) {
                if let centerTitle {
                    Text(centerTitle)
                        .setTypo(.subTitle3)
                        .foregroundStyle(Color.getColor(.text_strong))
                }
            }
        }
    }
    
    @ViewBuilder func navigationItem(_ item: NavigationItem) -> some View {
        Button(action: {
            item.1()
        }, label: {
            item.0
                .resizable()
                .frame(width: 24, height: 24)
                .padding(8)
        })
    }
}
