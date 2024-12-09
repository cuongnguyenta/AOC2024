import RegexBuilder

extension String {
    func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    mutating func trim() {
        self = self.trimmed()
    }

    func charAt(_ offset: Int) -> String {
        let ch = self[index(startIndex, offsetBy: offset)]
        return String(ch)
    }

    func substring(_ start: Int, _ len: Int) -> String {
        let end = index(startIndex, offsetBy: start + len)
        let start = index(startIndex, offsetBy: start)
        return String(self[start..<end])
    }

    func substring(after separator: String) -> String {
        guard let index = indexOf(separator) else { return self }
        let start = self.index(startIndex, offsetBy: index + 1)
        return String(self[start..<endIndex])
    }

    func indexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr) else {
            return nil
        }

        return distance(from: startIndex, to: range.lowerBound)
    }

    func indicesOf(_ substr: String) -> [Int] {
        var result = [Int]()
        var searchRange = startIndex..<endIndex
        while let r = self.range(of: substr, range: searchRange) {
            result.append(distance(from: startIndex, to: r.lowerBound))
            searchRange = index(r.lowerBound, offsetBy: 1)..<endIndex
        }
        return result
    }

    func lastIndexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr, options: .backwards) else {
            return nil
        }

        return distance(from: startIndex, to: range.lowerBound)
    }
}

// subscripts
extension String {
    subscript(index: Int) -> String {
        charAt(index)
    }

    subscript(range: ClosedRange<Int>) -> String {
        substring(range.lowerBound, range.upperBound - range.lowerBound + 1)
    }

    subscript(range: Range<Int>) -> String {
        substring(range.lowerBound, range.upperBound - range.lowerBound)
    }
}

// splitting
extension String {
    var lines: [String] {
        split(omittingEmptySubsequences: false, whereSeparator: \.isNewline).map { String($0) }
    }

    func asInts(separator: String = ",") -> [Int] {
        tokenized(separator: separator).map { Int($0)! }
    }

    func tokenized(separator: String = " ") -> [String] {
        split(separator: separator).map { String($0).trimmed() }
    }

    func allInts() -> [Int] {
        let regex = Regex {
            TryCapture {
                Optionally("-")
                ZeroOrMore(.digit)
            } transform: {
                Int($0)
            }
        }

        return matches(of: regex).map(\.output.1)
    }
}
