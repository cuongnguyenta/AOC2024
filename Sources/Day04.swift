import Foundation

struct Rule: Hashable {
    let page1: Int
    let page2: Int
}

struct Day04: AdventDay {
    private let rules: Set<Rule>
    private let updates: [[Int]]
    
    init(data: String) {
        let lines = data.components(separatedBy: .newlines)
        let separatorIndex = lines.firstIndex(of: "") ?? lines.count
        
        let rulesStrings = lines[..<separatorIndex]
        let updatesStrings = lines[(separatorIndex + 1)...]
        
        self.rules = Set(rulesStrings.map { ruleString -> Rule in
            let numbers = ruleString.components(separatedBy: "|").compactMap { Int($0) }
            return Rule(page1: numbers[0], page2: numbers[1])
        })
        
        self.updates = updatesStrings.map { update in
            update.components(separatedBy: ",").compactMap { Int($0) }
        }
    }
    
    private func satisfyToUpdate(_ update: [Int]) -> Bool {
        update
            .combinations(ofCount: 2)
            .map { Rule(page1: $0[0], page2: $0[1]) }
            .allSatisfy { rules.contains($0) }
    }
    func part1() -> Int {
        updates
            .filter { satisfyToUpdate($0) }
            .map { $0.median() }
            .reduce(0, +)
    }
    
    func part2() -> Int {
        updates
            .filter { !satisfyToUpdate($0) }
            .map {
                $0.sorted { p1, p2 in
                    rules.contains(Rule(page1: p1, page2: p2))
                }
            }
            .map { $0.median() }
            .reduce(0, +)
    }
}

extension Array where Element == Int {
    func median() -> Int {
        guard !isEmpty else { return 0 }
        let middleIndex = count / 2
        return self[middleIndex]
    }
}
