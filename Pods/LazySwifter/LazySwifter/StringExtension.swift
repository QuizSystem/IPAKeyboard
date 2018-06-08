//
//  StringExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/14/18.
//

import UIKit

public struct CommonRegex {
    public static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

public extension String {
    public func index(by distance: Int) -> String.Index? {
        if distance >= 0 {
            return index(startIndex, offsetBy: distance, limitedBy: endIndex)
        } else {
            return index(endIndex, offsetBy: distance, limitedBy: startIndex)
        }
    }

    public func index(from: Int, to: Int) -> String.Index? {
        guard let left = index(by: from) else {
            return nil
        }
        return index(left, offsetBy: to - from, limitedBy: endIndex)
    }

    // String[1]
    public subscript(index: Int) -> String {
        guard let idx = self.index(by: index) else {
            return ""
        }
        return String(self[idx])
    }

    // String[1..<2]
    public subscript(range: Range<Int>) -> String {
        guard let left = index(by: range.lowerBound) else {
            return ""
        }
        guard let right = index(from: range.lowerBound, to: range.upperBound) else {
            return ""
        }
        return String(self[left..<right])
    }

    // String[1...2]
    public subscript(range: ClosedRange<Int>) -> String {
        guard let left = index(by: range.lowerBound) else {
            return ""
        }
        guard let right = index(from: range.lowerBound, to: range.upperBound) else {
            return ""
        }
        return String(self[left...right])
    }

    // String[..<1]
    public subscript(range: PartialRangeUpTo<Int>) -> String {
        guard let right = index(from: 0, to: range.upperBound) else {
            return ""
        }
        return String(self[..<right])
    }

    // String[...1]
    public subscript(range: PartialRangeThrough<Int>) -> String {
        guard let right = index(from: 0, to: range.upperBound) else {
            return ""
        }
        return String(self[...right])
    }

    // String[1...]
    public subscript(range: PartialRangeFrom<Int>) -> String {
        guard let left = index(by: range.lowerBound) else {
            return ""
        }
        return String(self[left...])
    }

    // String["substring"]
    public subscript(string: String) -> [Range<String.Index>] {
        var occurences = [Range<String.Index>]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let range = self.range(
                of: string, options: [],
                range: initialLeftBound..<endIndex, locale: nil
            ) else {
                break
            }
            occurences.append(range)
            initialLeftBound = range.upperBound
        }
        return occurences
    }

    // String["begin"..."end"]
    public subscript(range: ClosedRange<String>) -> [ClosedRange<String.Index>] {
        var occurences = [ClosedRange<String.Index>]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let beginRange = self.range(
                of: range.lowerBound, options: [],
                range: initialLeftBound..<endIndex, locale: nil
            ) else {
                break
            }
            guard let endRange = self.range(
                of: range.upperBound, options: [],
                range: beginRange.upperBound..<endIndex, locale: nil
            ) else {
                break
            }
            occurences.append(beginRange.lowerBound...endRange.upperBound)
            initialLeftBound = endRange.upperBound
        }
        return occurences
    }

    // String["begin"..<"end"]
    public subscript(range: Range<String>) -> [Range<String.Index>] {
        var occurences = [Range<String.Index>]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let beginRange = self.range(
                of: range.lowerBound, options: [],
                range: initialLeftBound..<endIndex, locale: nil
            ) else {
                break
            }
            guard let endRange = self.range(
                of: range.upperBound, options: [],
                range: beginRange.upperBound..<endIndex, locale: nil
            ) else {
                break
            }
            occurences.append(beginRange.upperBound..<endRange.lowerBound)
            initialLeftBound = endRange.upperBound
        }
        return occurences
    }

    // String[Character("a")]
    public subscript(character: Character) -> [String.Index] {
        var occurences = [String.Index]()
        var initialLeftBound = startIndex
        while initialLeftBound < endIndex {
            guard let beginRange = self.range(
                of: String(character), options: [],
                range: initialLeftBound..<endIndex, locale: nil
            ) else {
                break
            }
            occurences.append(beginRange.lowerBound)
            initialLeftBound = beginRange.upperBound
        }
        return occurences
    }

    // String["begin"...]
    public subscript(range: PartialRangeFrom<String>) -> PartialRangeFrom<String.Index>? {
        guard self.index(by: range.lowerBound.count) != nil else {
            return nil
        }
        guard let beginRange = self.range(
            of: range.lowerBound, options: [],
            range: startIndex..<endIndex, locale: nil
        ) else {
            return nil
        }
        return beginRange.upperBound...
    }

    // String[..."end"]
    public subscript(range: PartialRangeThrough<String>) -> PartialRangeThrough<String.Index>? {
        guard self.index(by: range.upperBound.count) != nil else {
            return nil
        }
        guard let endRange = self.range(
            of: range.upperBound, options: [],
            range: startIndex..<endIndex, locale: nil
        ) else {
            return nil
        }
        return ...endRange.lowerBound
    }
}

public extension String {
    public var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }

    public static func * (text: String, times: Int) -> String {
        return String(repeating: text, count: times)
    }

    public func trimmed() -> String {
        let trim = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let regex = try? NSRegularExpression(pattern: "\\s+", options: .caseInsensitive) else {
            return trim
        }
        let range = NSMakeRange(0, trim.count)
        return regex.stringByReplacingMatches(in: trim, options: [], range: range, withTemplate: " ")
    }

    public var isEmail: Bool {
        let emailRegEx = CommonRegex.email
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
