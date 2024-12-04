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
        return countSafeReports(entities: entities)
    }
    
    func part2() -> Any {
        entities.filter { entity in
            isSafeOrCorrectable(entity)
        }.count
    }
}

private extension Day01 {
    func countSafeReports(entities: [[Int]]) -> Int {
        var res: Int = 0
        for entity in entities {
            // Check if the entity is either increasing or decreasing
            if checkSafe(entity: entity) {
                res += 1
            }
        }
        
        return res
    }
    
    func checkSafe(entity: [Int]) -> Bool {
        if (isIncreasing(entity) || isDecreasing(entity)) {
            for i in 1..<entity.count {
                let diff = abs(entity[i] - entity[i - 1])
                if diff < 1 || diff > 3 {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func isSafeOrCorrectable(_ report: [Int]) -> Bool {
        guard !checkSafe(entity: report) else { return true }
        let length = report.count
        var i = 0
        var correctable = false
        
        while i < length, !correctable {
            var arr = report
            arr.remove(at: i)
            correctable = checkSafe(entity: arr)
            i += 1
        }
        
        return correctable
    }
    
    func countUnsafeReports(entities: [[Int]]) -> [Int] {
        var res: [Int] = []
        for (i,entity) in entities.enumerated() {
            // Check if the entity is either increasing or decreasing
            if (isIncreasing(entity) || isDecreasing(entity)) {
                var isUnsafe = false
                
                // Check all adjacent differences
                for i in 1..<entity.count {
                    let diff = abs(entity[i] - entity[i - 1])
                    if diff < 1 || diff > 3 {
                        isUnsafe = true
                        break // No need to check further if one difference fails
                    }
                }
                // If all differences are safe, increment the result
                if isUnsafe {
                    res.append(i)
                }
            } else {
                res.append(i)
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
}
