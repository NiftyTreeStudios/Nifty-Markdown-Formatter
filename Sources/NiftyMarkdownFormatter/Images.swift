//
//  Images.swift
//  
//  Created by Iiro Alhonen on 7.4.2022.
//

import SwiftUI

internal func formatImageComponents(_ string: String) -> (String, URL?) {
    var altTextString = string
    altTextString.removeSubrange(altTextString.startIndex...altTextString.index(altTextString.startIndex, offsetBy: 1))
    let startIndex = altTextString.firstIndex(of: "]")
    let endIndex = altTextString.index(before: altTextString.endIndex)
    altTextString.removeSubrange((startIndex!)...endIndex)

    var imageUrlString = string
    imageUrlString.removeSubrange(imageUrlString.startIndex...imageUrlString.firstIndex(of: "(")!)
    imageUrlString.removeSubrange(((imageUrlString.firstIndex(of: " ") ?? imageUrlString.firstIndex(of: ")")) ?? imageUrlString.index(before: imageUrlString.endIndex))...imageUrlString.index(before: imageUrlString.endIndex))
    print(imageUrlString)

    return (altTextString, URL(string: imageUrlString))
}

/**
 Formats images.

 - Parameter altText: String representing the alt text of the image.
 - Parameter url: The url pointing to the image.

 - Returns: a `some View` containing an `AsyncImage` view.
 */
@available(iOS 15, macOS 12, *)
internal func formatImage(altText: String?, url: URL?) -> some View {
    let image = AsyncImage(url: url) { image in
        image
            .resizable()
            .accessibilityLabel(altText ?? "")
    } placeholder: {
        ProgressView()
    }
    return image
}
