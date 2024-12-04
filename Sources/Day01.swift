import Algorithms

struct Day01: AdventDay {
    var data: String
    
    var entities: [[Int]] {
        data.components(separatedBy: .newlines).compactMap { line in
            line.split(separator: " ").compactMap { Int($0) }
        }.filter { entity in
            entity.count > 1
        }
    }
    
    func part1() -> Any {
        // conditions: all increasing or all decresing, adjacent at least one and at most three
        func countSafeReports(entities: [[Int]]) -> Int {
            var res: Int = 0
            for entity in entities {
                // Check if the entity is either increasing or decreasing
                if (isIncreasing(entity) || isDecreasing(entity)) {
                    var isSafe = true
                    
                    // Check all adjacent differences
                    for i in 1..<entity.count {
                        let diff = abs(entity[i] - entity[i - 1])
                        if diff < 1 || diff > 3 {
                            isSafe = false
                            break // No need to check further if one difference fails
                        }
                    }
                    // If all differences are safe, increment the result
                    if isSafe {
                        res += 1
                    }
                }
            }
            
            return res
        }

        func isIncreasing(_ arr: [Int]) -> Bool {
            for i in 1..<arr.count {
                if arr[i] < arr[i - 1] {
                    return false
                }
            }
            return true
        }

        func isDecreasing(_ arr: [Int]) -> Bool {
            for i in 1..<arr.count {
                if arr[i] > arr[i - 1] {
                    return false
                }
            }
            return true
        }

        let safeReportsCount = countSafeReports(entities: entities)
        print("Number of safe reports: \(safeReportsCount)")

        
        return safeReportsCount
    }
    
    func part2() -> Any {
        return "Not implemented"
    }
}
