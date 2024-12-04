import Algorithms
import Foundation

struct Day02: AdventDay {
    var data: String
    
    func part1() -> Any {
        let nums = multiplicationPattern(data)
        return nums.reduce(0, +)
    }
    
    func part2() -> Any {
        return "Not implemented"
    }
}

private extension Day02 {
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
}
