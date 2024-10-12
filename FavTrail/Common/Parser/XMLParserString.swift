//
//  XMLParserString.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 15/01/23.
//

import Foundation
import UIKit

enum XMLParsingError: Error {
    case parsingFailed
}

final class AttributedStringBuilder: NSObject {
    
    let initString: String
    var currentElement: [ElementType] = []
    var currentElementAttribute: [NSAttributedString.Key: Any] = [:]
    var finalString: NSAttributedString
    var currentString: NSMutableAttributedString = NSMutableAttributedString(string: .empty())
    
    init(initString: String) {
        self.initString = initString
        self.finalString = NSAttributedString(string: initString)
    }
    
    enum ElementType: String {
        case format
        case text
        case link
    }
    
    enum AttributeType: String {
        case fg_clr
        case bg_clr
    }
    
    func parseStr() -> NSAttributedString {
        guard let strData = initString.data(using: .utf8) else { return NSAttributedString(string: initString) }
        let xmlParser = XMLParser(data: strData)
        xmlParser.delegate = self
        xmlParser.parse()
        
        return finalString
    }
}

extension AttributedStringBuilder: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        guard let element = ElementType(rawValue: elementName) else { return }
        currentElement.append(element)
        
        attributeDict.forEach { (key, val) in
            if let attribute = AttributeType(rawValue: key) {
                switch attribute {
                case .fg_clr:
                    currentElementAttribute[.foregroundColor] = UIColor(hex: val)
                case .bg_clr:
                    currentElementAttribute[.backgroundColor] = UIColor(hex: val)
                }
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement.removeLast()
        currentElementAttribute = [:]
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement.last {
        case .format:
            currentString.append(NSAttributedString(string: string))
        case .text:
            let attrStr = NSAttributedString(string: string, attributes: currentElementAttribute)
            currentString.append(attrStr)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {}
    
    func parserDidEndDocument(_ parser: XMLParser) {
        if !currentString.string.isEmpty {
            finalString = currentString
        }
        currentElementAttribute = [:]
    }
    
}
