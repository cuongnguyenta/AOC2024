import Algorithms
import Foundation

struct Day03: AdventDay {
    var data: String
    
    func part1() -> Any {
        let nums = multiplicationPattern(data)
        return nums.reduce(0, +)
    }
    
    func part2() -> Any {
        let nums = multiEnabledPairs(data)
        return nums.reduce(0, +)
    }
}

private extension Day03 {
    func multiplicationPattern(_ data: String) -> [Int] {
        // Define the regex pattern
        let pattern = "mul\\((\\d+),(\\d+)\\)"
        var result: [Int] = []
        // Create a regular expression object
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            // Find all matches in the string
            let matches = regex.matches(in: data, options: [], range: NSRange(data.startIndex..., in: data))

            // Extract number pairs and perform multiplication
            result = matches.compactMap { match -> Int? in
                guard let range1 = Range(match.range(at: 1), in: data),
                      let range2 = Range(match.range(at: 2), in: data),
                      let num1 = Int(data[range1]),
                      let num2 = Int(data[range2]) else {
                    return nil
                }
                return num1 * num2
            }
        }
        return result
    }
    
    func multiEnabledPairs(_ input: String) -> [Int] {
        let pattern = #"(\w*do\(\)|\w*don't\(\)|mul\((\d+),(\d+)\))"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: input, options: [], range: NSRange(input.startIndex..., in: input))

        var isEnabled = true
        var results: [Int] = []

        for match in matches {
            let matchedString = String(input[Range(match.range, in: input)!])
            
            if matchedString.hasSuffix("do()") {
                isEnabled = true
            } else if matchedString.hasSuffix("don't()") {
                isEnabled = false
            } else if matchedString.starts(with: "mul(") && isEnabled {
                let x = Int(input[Range(match.range(at: 2), in: input)!])!
                let y = Int(input[Range(match.range(at: 3), in: input)!])!
                results.append(x * y)
            }
        }
        return results
    }
}
