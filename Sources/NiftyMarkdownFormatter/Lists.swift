//
//  Lists.swift
//
//  Created by Iiro Alhonen on 7.4.2022.
//

import SwiftUI

/**
 Formats ordered lists.

 - Parameter string: the markdown string to be formatted into an ordered list item.

 - Returns: a `Text` view formatted into an ordered list item.
 */
internal func formatOrderedListItem(_ string: String) -> AnyView {
    let regex = "^[0-9*]."
    if string.range(of: regex, options: .regularExpression) != nil {
        var orderedItem = string
        var orderedPrefix = string
        orderedPrefix.removeSubrange(
            (orderedItem.firstIndex(of: " ") ?? orderedItem.startIndex)..<orderedItem.endIndex
        )
//        orderedItem.replaceSubrange(
//            orderedItem.startIndex...(
//                orderedItem.firstIndex(of: ".") ?? orderedItem.startIndex
//            ),
//            with: "**\(orderedPrefix)**")
        orderedItem.removeSubrange(orderedItem.startIndex...(
            orderedItem.firstIndex(of: " ") ?? orderedItem.startIndex
        ))
        return AnyView(
            HStack {
                VStack(alignment: .leading) {
                    Text(orderedPrefix).bold().padding(.top, 9)
                    Spacer()
                }
                Text(orderedItem)
                    .multilineTextAlignment(.leading)
            }
        )
    } else {
        return AnyView(Text(string))
    }
}

/**
 Formats unordered lists.

 - Parameter string: the markdown string to be formatted into an unordered list item.

 - Returns: a `Text` view formatted into an ordered list item.
 */
internal func formatUnorderedListItem(_ string: String) -> String {
    if string.starts(with: "* ") {
        var orderedItem = string
        var orderedPrefix = string
        orderedPrefix.removeSubrange(
            (orderedItem.firstIndex(of: " ") ?? orderedItem.startIndex)..<orderedItem.endIndex
        )
        orderedItem.removeSubrange(orderedItem.startIndex...(
            orderedItem.firstIndex(of: " ") ?? orderedItem.startIndex
        ))
        return orderedItem
    } else {
        return string
    }
}
