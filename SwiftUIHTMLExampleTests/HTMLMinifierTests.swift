//  Copyright © 2025 PRND. All rights reserved.
import Foundation
import Testing
@testable import SwiftUIHTML


class HTMLMinifierTests {

    @Test
    func testBasicMinification() async throws {
        let input = """
        <div>
            <p>This is a test</p>
        </div>
        """

        let expected = "<div><p>This is a test</p></div>"
        let result = HTMLMinifier.minify(input)

        #expect(result == expected)
    }

    @Test
    func testBRTagWhitespaceRemoval() async throws {
        let input = """
        <p>List format:<br>
            - First item<br>
            - Second item<br>
            - Third item</p>
        """

        let expected = "<p>List format:<br>- First item<br>- Second item<br>- Third item</p>"
        let result = HTMLMinifier.minify(input)

        #expect(result == expected)
    }

    @Test
    func testAttributeSpaceHandling() async throws {
        let input = """
            <a  href = "https://example.com"  target = "_blank"  class = "link" >Link</a>
            """

        let expected = "<a  href = \"https://example.com\"  target = \"_blank\"  class = \"link\" >Link</a>"
        let result = HTMLMinifier.minify(input)
        print("WANI", result)
        #expect(result == expected)
    }

    @Test
    func testInlineTagSpacePreservation() async throws {
        let input = "<p>Testing when multiple inline elements are <span>listed</span> <strong>in</strong> <em>sequence</em> <span>continuously</span>.</p>"

        let expected = "<p>Testing when multiple inline elements are <span>listed</span>&nbsp;<strong>in</strong>&nbsp;<em>sequence</em>&nbsp;<span>continuously</span>.</p>"
        let result = HTMLMinifier.minify(input)

        #expect(result == expected)
    }

    @Test
    func testMultipleSpacesHandling() async throws {
        let input = "<p>Text with    multiple    spaces    between words</p>"

        let expected = "<p>Text with    multiple    spaces    between words</p>"
        let result = HTMLMinifier.minify(input)

        #expect(result == expected)
    }

    @Test
    func testComplexHTMLStructure() async throws {
        let input = """
        <div id="container">
            <header>
                <h1>Title</h1>
                <nav>
                    <a href="#">Home</a> <a href="#">About</a> <a href="#">Contact</a>
                </nav>
            </header>
            <main>
                <article>
                    <p>Paragraph with <em>emphasized</em> text and <strong>strong</strong> elements.</p>
                    <ul>
                        <li>Item 1</li>
                        <li>Item 2</li>
                    </ul>
                </article>
            </main>
        </div>
        """

        let result = HTMLMinifier.minify(input)
        let expected = "<div id=\"container\"><header><h1>Title</h1><nav><a href=\"#\">Home</a>&nbsp;<a href=\"#\">About</a>&nbsp;<a href=\"#\">Contact</a></nav></header><main><article><p>Paragraph with <em>emphasized</em> text and <strong>strong</strong> elements.</p><ul><li>Item 1</li><li>Item 2</li></ul></article></main></div>"

        #expect(result == expected)
    }

    @Test
    func testEmptyHTML() async throws {
        let input = ""
        let result = HTMLMinifier.minify(input)
        #expect(result == "")
    }

    @Test
    func testMalformedHTML() async throws {
        let input = "<div><p>Unclosed paragraph tag"
        let result = HTMLMinifier.minify(input)
        #expect(result == "<div><p>Unclosed paragraph tag")
    }

    @Test
    func testWhitespaceHandling() async throws {
        let input = """
            <header>
                <h1>Testing Basic HTML Elements</h1>
                <p>This is an example showcasing various fundamental HTML elements.</p>
            </header>

            <main>
                <section>
                    <h2>Text-related Elements</h2>
                    <p>Testing <strong>strong</strong> and <em>emphasized</em> text.<br>Also, checking line breaks (`<br>`).</p>
                    <p>Testing multiple line breaks:<br><br>Text remains visible after two line breaks.</p>
                </section>

                <section>
                    <h2>Links and Styles</h2>
                    <p>Here's text with <span style="color: blue;">applied styles</span> and <a href="https://example.com" target="_blank">a link that opens in a new tab</a>.</p>
                </section>

                <section>
                    <h2>List-related Elements</h2>
                    <p>An example of an unordered list:</p>
                    <ul>
                        <li>First item</li>
                        <li>Second item</li>
                        <li>Third item</li>
                    </ul>
                </section>

                <section>
                    <h2>Inline Elements Test</h2>
                    <p>Testing the rendering of multiple inline elements (<span>span</span>, <strong>strong</strong>, <em>em</em>) used consecutively.</p>
                </section>
            </main>

            <footer>
                <p>&copy; 2025 Basic HTML Test Page</p>
            </footer>
            """
        let result = HTMLMinifier.minify(input)
        let exprctString = """
            <header><h1>Testing Basic HTML Elements</h1><p>This is an example showcasing various fundamental HTML elements.</p></header><main><section><h2>Text-related Elements</h2><p>Testing <strong>strong</strong> and <em>emphasized</em> text.<br>Also, checking line breaks (`<br>`).</p><p>Testing multiple line breaks:<br><br>Text remains visible after two line breaks.</p></section><section><h2>Links and Styles</h2><p>Here's text with <span style="color: blue;">applied styles</span> and <a href="https://example.com" target="_blank">a link that opens in a new tab</a>.</p></section><section><h2>List-related Elements</h2><p>An example of an unordered list:</p><ul><li>First item</li><li>Second item</li><li>Third item</li></ul></section><section><h2>Inline Elements Test</h2><p>Testing the rendering of multiple inline elements (<span>span</span>, <strong>strong</strong>, <em>em</em>) used consecutively.</p></section></main><footer><p>&copy; 2025 Basic HTML Test Page</p></footer>
            """
        #expect(result == exprctString)
    }
    
    @Test
    func testPerformance() async throws {
        // Performance test - measuring processing time for large HTML
        let largeHTML = String(repeating: """
        <div>
            <p>Performance test with lots of whitespace     and   multiple    spaces</p>
            <ul>
                <li>Item   with    spaces</li>
                <li>Another    item</li>
            </ul>
        </div>
        """, count: 9999)

        let startTime = Date()
        _ = HTMLMinifier.minify(largeHTML)
        let endTime = Date()

        let processingTime = endTime.timeIntervalSince(startTime)
        print("Processing time for large HTML: \(processingTime) seconds")

        // Should be processed within 1 second
        #expect(processingTime < 1.0)
    }
}
