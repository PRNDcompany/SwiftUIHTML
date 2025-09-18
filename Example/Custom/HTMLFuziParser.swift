//  Copyright © 2025 PRND. All rights reserved.
import Foundation

import SwiftUIHTML
import Fuzi

struct HTMLFuziParser: HTMLParserable {
    struct ParserError: LocalizedError {
        let errorDescription: String?
    }
    init() {

    }

    func parse(html: String) -> HTMLNode {
        do {
            let _html = WhiteSpace(html: html).toNormal()
            let document = try HTMLDocument.parse(string: _html, encoding: String.Encoding.utf8)

            guard let rootElement = document.root else {
                throw ParserError(errorDescription: "No body element found")
            }
            return try elementToHTMLNode(element: rootElement)
        } catch {
            return HTMLNode(tag: "div", children: [.text("failed parsing HTML: \(error.localizedDescription)")])
        }
    }

    func elementToHTMLNode(element: Fuzi.XMLElement) throws -> HTMLNode {
        let tag = element.tag ?? ""

        let attributes = element.attributes.reduce(into: [String: String]()) { result, attribute in
            result[attribute.key] = attribute.value
        }

        let children: [HTMLChild] = try element.childNodes(ofTypes: [.Element, .Text]).compactMap { node -> HTMLChild? in
            if node.type == .Text {
                let text = node.stringValue
                return text.isEmpty ? nil : .text(text)
            } else if let element = node.toElement() {
                if element.tag == "br" {
                    return .newLine
                }
                return .node(try elementToHTMLNode(element: element))
            } else {
                return nil
            }
        }

        return HTMLNode(tag: tag, attributes: attributes, children: children)
    }

    struct WhiteSpace {
        let html: String

        func toNormal() -> String {
            var result = html
            
            // Remove line breaks before tags: \n<tag> → <tag>
            result = result.replacingOccurrences(
                of: #"\n\s*(?=<\/?[a-zA-Z])"#,
                with: "",
                options: .regularExpression
            )
            
            // Remove line breaks right after tags: <tag>\ntext → <tag>text
            result = result.replacingOccurrences(
                of: #"(?<=>)\s*\n\s*(?=[^<])"#,
                with: "",
                options: .regularExpression
            )
            
            return result
        }
    }
}
