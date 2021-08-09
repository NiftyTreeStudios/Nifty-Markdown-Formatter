
import SwiftUI

// MARK: Public

/**
 SwiftUI view with formatted markdown. The formatted markdown is wrapped in a `VStack` with no extra view modifiers.
 
 - Parameter markdown: The text needed to be formatted, as a `String`
 */
public struct FormattedMarkdown: View {
    public init(markdown: String) {
        self.markdown = markdown
    }
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

/**
 Formats the markdown.

 - Parameter markdown: the markdown to be formatted as a `String`.
 
 - Returns: array of `Text` views.
 */
public func formattedMarkdownArray(markdown: String) -> [Text] {
    var formattedTextViews: [Text] = []
    let splitStrings: [String] = markdown.components(separatedBy: "\n")
    for string in splitStrings {
        if string.starts(with: "#") {
            let heading = formatHeading(convertMarkdownHeading(string))
            formattedTextViews.append(heading)
        } else if string.range(of: "^[0-9].") != nil {
            formattedTextViews.append(Text(formatOrderedListItem(string)))
        } else if string.count == 0 {
            // Ignore empty lines
        } else {
            if #available(iOS 15, macOS 12, *) {
                if let attributedString = try? AttributedString(markdown: string) {
                    formattedTextViews.append(Text(attributedString))
                } else {
                    formattedTextViews.append(Text(string))
                }
            } else {
                formattedTextViews.append(Text(string))
            }
        }
    }
    
    return formattedTextViews
}

// MARK: Private

// MARK: Heading
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
    } else if formattedText.headingSize == 4 {
        return Text(formattedText.text).font(.headline)
    } else if formattedText.headingSize >= 6 {
        return Text(formattedText.text).font(.subheadline)
    } else {
        return Text(formattedText.text).font(.body)
    }
}

/**
 Formats ordered lists.
 
 - Parameter string: the markdown string to be formatted into an ordered list item.
 
 - Returns: a `Text` view formatted into an ordered list item.
 */
internal func formatOrderedListItem(_ string: String) -> String {
    let regex = "^[0-9]."
    if string.range(of: regex, options: .regularExpression) != nil  {
        var orderedItem = string
        var orderedPrefix = string
        orderedPrefix.removeSubrange(
            (orderedItem.firstIndex(of: " ") ?? orderedItem.startIndex)..<orderedItem.endIndex
        )
        orderedItem.replaceSubrange(
            orderedItem.startIndex...(
                orderedItem.firstIndex(of: ".") ?? orderedItem.startIndex
            ),
            with: "**\(orderedPrefix)**")
        return orderedItem
    } else {
        return string
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
