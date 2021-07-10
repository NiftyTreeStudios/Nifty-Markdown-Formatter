
import SwiftUI

/// Heading struct used to represent headings.
private struct Heading: Identifiable {
    let id = UUID()
    let text: String
    let headingSize: Int
}

/**
 Formats the markdown.

 - Parameter markdown: the markdown to be formatted as a `String`.
 
 - Returns: array of `Text` views.
 */
public func formattedMarkdownArray(markdown: String) -> [Text] {
    var formattedTextViews: [Text] = []
    let splitStrings: [String] = markdown.components(separatedBy: "\n")
    for string in splitStrings {
        if markdown.starts(with: "#") {
            let headingSize = markdown.distance(
                from: markdown.startIndex,
                to: markdown.firstIndex(of: " ") ?? markdown.startIndex
            )
            var headingText = string
            headingText.removeSubrange(
                headingText.startIndex...(headingText.firstIndex(of: " ")
                                          ?? headingText.startIndex)
            )
            let heading = formattedHeading(Heading(
                text: headingText,
                headingSize: headingSize
            ))
            formattedTextViews.append(heading)
        } else {
            if #available(iOS 15, macOS 12, *) {
                if let attributedString = try? AttributedString(markdown: markdown) {
                    formattedTextViews.append(Text(attributedString))
                } else {
                    formattedTextViews.append(Text(markdown))
                }
            } else {
                formattedTextViews.append(Text(markdown))
            }
        }
    }
    
    return formattedTextViews
}

/**
 Formats heading by giving it a correct font size.
 
 - Parameter heading: the heading to be formatted.
 
 - Returns: `Text` view with corrent font sizing.
 */
private func formattedHeading(_ formattedText: Heading) -> Text {
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
    } else if formattedText.headingSize == 4 {
        return Text(formattedText.text).font(.headline)
    } else if formattedText.headingSize >= 6 {
        return Text(formattedText.text).font(.subheadline)
    } else {
        return Text(formattedText.text).font(.body)
    }
}

/**
 SwiftUI view with formatted markdown. The formatted markdown is wrapped in a `VStack` with no extra view modifiers.
 
 - Parameter markdown: The text needed to be formatted, as a `String`
 */
public struct FormattedMarkdown: View {
    
    let markdown: String
    
    public var body: some View {
        let formattedStrings = formattedMarkdownArray(markdown: markdown)
        VStack {
            ForEach(0..<formattedStrings.count, id: \.self) { textView in
                formattedStrings[textView]
            }
        }
    }
}


