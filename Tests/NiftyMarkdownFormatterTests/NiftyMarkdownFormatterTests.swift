import XCTest
import SwiftUI
@testable import NiftyMarkdownFormatter

final class NiftyMarkdownFormatterTests: XCTestCase {
    
    // MARK: Header
    func testHeaderConversion() throws {
        let testString = "# Test"
        let expected = Heading(text: "Test", headingSize: 1)
        let actual = convertMarkdownHeading(testString)
        XCTAssertEqual(expected.text, actual.text)
        XCTAssertEqual(expected.headingSize, actual.headingSize)
    }
    
    func testHeaderConversion2() throws {
        let testString = "## Another test"
        let expected = Heading(text: "Another test", headingSize: 2)
        let actual = convertMarkdownHeading(testString)
        XCTAssertEqual(expected.text, actual.text)
        XCTAssertEqual(expected.headingSize, actual.headingSize)
    }
    
    // MARK: Ordered list
    func testOrderedList() throws {
        let testString = "1. List item"
        let excepted = "**1.** List item"
        let actual = formatOrderedListItem(testString)
        XCTAssertEqual(excepted, actual)
    }
    
    func testOrderedList2() throws {
        let testString = "9. List item"
        let excepted = "**9.** List item"
        let actual = formatOrderedListItem(testString)
        XCTAssertEqual(excepted, actual)
    }
    
    func testOrderedListWithWrongInput() throws {
        let testString = "No correct prefix."
        let expected = testString
        let actual = formatOrderedListItem(testString)
        XCTAssertEqual(expected, actual)
    }
    
    // MARK: Unordered list
    func testUnorderedList() throws {
        let testString = "* List item"
        let excepted = "***** List item"
        let actual = formatUnorderedListItem(testString)
        XCTAssertEqual(excepted, actual)
    }
    
    func testUnorderedList2() throws {
        let testString = "* List item"
        let excepted = "***** List item"
        let actual = formatUnorderedListItem(testString)
        XCTAssertEqual(excepted, actual)
    }
    
    func testUnorderedListWithWrongInput() throws {
        let testString = "No correct prefix."
        let expected = testString
        let actual = formatUnorderedListItem(testString)
        XCTAssertEqual(expected, actual)
    }
}
