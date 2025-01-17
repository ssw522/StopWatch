//
//  FlexibleHStack.swift
//  Receive
//
//  Created by iOS신상우 on 9/4/24.
//

import SwiftUI


/// 수평으로 유연하게 배치해주는 HStack 기존 HStack과 다르게 필요시에 다음 라인으로 넘어감
public struct FlexibleHStack: Layout {
    
    /*
     Layout프로토콜은 컨테이너뷰의 기하학을 정의하는 프로토콜임 ( 위치, 크기 정보 등 )
     HStack, Grid 등 보다 더 커스텀한 기능을 원할때 직접 채택하여 구현할 수 있음
     sizeThatFits, placeSubviews 메소드를 구현해야함
     */
    
    // MARK: - Properties
    
    /// 정렬을 나타냄
    var alignment: Alignment = .leading
    
    /// 수평 스페이싱
    public var horizontalSpacing: CGFloat = 8
    
    /// 수직 스페이싱
    public var verticalSpacing: CGFloat = 8
    
    /// `true`: 컨테이너가 최대 넓이 공간을 사용
    /// `false`: 컨테이너가 내부 뷰 크기에 맞게 넓이 공간을 사용
    public var isContainerFullWidth: Bool = true
    
    /// 컨테이너뷰의 사이즈를 결정함
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let Rows = arrangeRows(proposal: proposal, subviews: subviews, cache: &cache)
        
        if Rows.isEmpty { return cache.minSize }
        
        var width: CGFloat = Rows.map { $0.width }.reduce(.zero) { max($0, $1) }
        
        if isContainerFullWidth, let proposalWidth = proposal.width {
            width = max(width, proposalWidth)
        }
        
        var height: CGFloat = .zero
        if let lastRow = Rows.last {
            height = lastRow.yOffset + lastRow.height
        }
        
        return CGSize(width: width, height: height)
    }
    
    /// 컨테이너 하위뷰의 크기와 위치를 지정함
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        let rows = arrangeRows(proposal: proposal, subviews: subviews, cache: &cache)
        
        let anchor = UnitPoint(alignment)
        
        for row in rows {
            for item in row.items {
                let x: CGFloat = item.xOffset + anchor.x * (bounds.width - row.width)
                let y: CGFloat = row.yOffset + anchor.y * (row.height - item.size.height)
                let point = CGPoint(x: x + bounds.minX, y: y + bounds.minY)
                
                subviews[item.index].place(at: point, anchor: .topLeading, proposal: proposal)
            }
        }
    }
    
    
    // MARK: - Cache
    
    public struct Cache {
        
        /// 컨테이너뷰의 최소크기
        var minSize: CGSize
        
        /// 캐싱된 아이템
        var rows: (Int, [Row])?
    }
    
    public func makeCache(subviews: Subviews) -> Cache {
        Cache(minSize: minSize(subviews: subviews))
    }
    
    
    // MARK: - Row
    
    struct Row {
        typealias Item = (index: Int, size: CGSize, xOffset: CGFloat)
        
        var items: [Item] = []
        var yOffset: CGFloat = .zero
        var width: CGFloat = .zero
        var height: CGFloat = .zero
    }
    
}

private extension FlexibleHStack {
    func computeHash(proposal: ProposedViewSize, sizes: [CGSize]) -> Int {
        let proposal = proposal.replacingUnspecifiedDimensions(by: .init(width: CGFloat.infinity, height: CGFloat.infinity))
        
        var hasher = Hasher()
        
        for size in [proposal] + sizes {
            hasher.combine(size.width)
            hasher.combine(size.height)
        }
        
        return hasher.finalize()
    }
    
    func minSize(subviews: Subviews) -> CGSize {
        subviews
            .map { $0.sizeThatFits(.zero) }
            .reduce(CGSize.zero) { CGSize(width: max($0.width, $1.width), height: max($0.height, $1.height)) }
    }
    
    func arrangeRows(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Cache
    ) -> [Row] {
        if subviews.isEmpty {
            return []
        }
        
        if cache.minSize.width > proposal.width ?? .infinity,
           cache.minSize.height > proposal.height ?? .infinity {
            return []
        }
        
        let sizes = subviews.map { $0.sizeThatFits(proposal) }
        
        let hash = computeHash(proposal: proposal, sizes: sizes)
        if let (oldHash, oldRows) = cache.rows,
           oldHash == hash {
            return oldRows
        }
        
        var currentX = CGFloat.zero
        var curentRow = Row()
        var rows = [Row]()
        
        for index in subviews.indices {
            
            let size = sizes[index]
            
            if currentX + size.width + horizontalSpacing > proposal.width ?? .infinity,
               curentRow.items.isNotEmpty {
                curentRow.width = currentX
                rows.append(curentRow)
                curentRow = Row()
                currentX = .zero
            }
            
            curentRow.items.append((index, sizes[index], currentX + horizontalSpacing))
            currentX += size.width + horizontalSpacing
        }
        
        if curentRow.items.isNotEmpty {
            curentRow.width = currentX
            rows.append(curentRow)
        }
        
        var currentY = CGFloat.zero
        var previousMaxHeightIndex: Int?
        
        for index in rows.indices {
            let maxHeightIndex = rows[index].items
                .max { $0.size.height < $1.size.height }!
                .index
            
            let size = sizes[maxHeightIndex]
            
            var spacing = CGFloat.zero
            if let _ = previousMaxHeightIndex {
                spacing = verticalSpacing
            }
            
            rows[index].yOffset = currentY + spacing
            currentY += size.height + spacing
            rows[index].height = size.height
            previousMaxHeightIndex = maxHeightIndex
        }
        
        cache.rows = (hash, rows)
        
        return rows
    }
}
