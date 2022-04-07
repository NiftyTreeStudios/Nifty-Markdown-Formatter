//
//  Headings.swift
//
//  Created by Iiro Alhonen on 7.4.2022.
//

import SwiftUI

/// Heading struct used to represent headings.
internal struct Heading: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let headingSize: Int
}

/**
 Formats a markdown heading into a custom `Heading` struct.

 - Parameter string: the markdown string to be formatted.

 - Returns: a `Heading` with the correct heading size.
 */
internal func convertMarkdownHeading(_ string: String) -> Heading {
    let headingSize = string.distance(
        from: string.startIndex,
        to: string.firstIndex(of: " ") ?? string.startIndex
    )
    var headingText = string
    headingText.removeSubrange(
        headingText.startIndex...(
            headingText.firstIndex(of: " ") ?? headingText.startIndex
        )
    )
    return Heading(text: headingText, headingSize: headingSize)
}

/**
 Formats heading by giving it a correct font size.

 - Parameter heading: the heading to be formatted.

 - Returns: `Text` view with corrent font sizing.
 */
internal func formatHeading(_ formattedText: Heading) -> Text {
    if formattedText.headingSize <= 0 {
        return Text(formattedText.text).font(.body)
    } else if formattedText.headingSize == 1 {
        return Text(formattedText.text).font(.largeTitle)
    } else if formattedText.headingSize == 2 {
        return Text(formattedText.text).font(.title)
    } else if formattedText.headingSize == 3 {
        return Text(formattedText.text).font(.title2)
    } else if formattedText.headingSize == 4 {
        return Text(formattedText.text).font(.title3)
    } else if formattedText.headingSize == 5 {
        return Text(formattedText.text).font(.headline)
    } else if formattedText.headingSize >= 6 {
        return Text(formattedText.text).font(.subheadline)
    } else {
        return Text(formattedText.text).font(.body)
    }
}
