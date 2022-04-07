//
//  File.swift
//  
//
//  Created by Iiro Alhonen on 7.4.2022.
//

import SwiftUI

/**
 Formats images.

 - Parameter string: the markdown string to be formatted into an image.

 - Returns: a `some View` containing an `AsyncImage` view.
 */
@available(macOS 12.0, *)
internal func formatImage(_ string: String) -> some View {
    // With extra readability !\[[^\]]*\]\((?<filename>.*?)(?=\"|\))(?<optionalpart>\".*\")?\)
    // let imgRegex: NSRegularExpression = NSRegularExpression("!\[[^\]]*\]\((.*?)\s*("(?:.*[^"])")?\s*\)")

    let url: URL? = URL(string: string)
    let altText: String = string
    let image = AsyncImage(url: url) { image in
        image.accessibilityLabel(altText)
    } placeholder: {
        ProgressView()
    }
    return image
}
