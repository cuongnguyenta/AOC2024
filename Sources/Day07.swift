import Foundation
import Parsing

struct Day07: AdventDay {
    let data: String
    init(data: String) {
        self.data = data
    }
    
    var calibrations: [Calibration] {
        do {
            return try CalibrationsParser().parse(data)
        } catch {
            fatalError("Unable to parse data: \(error)")
        }
    }
    
    func part1() -> Int {
        calibrations.filter(\.isValid).map(\.target).reduce(0, +)
    }
    
    func part2() -> Int {
        calibrations.filter(\.isValidWithConcoatenation).map(\.target).reduce(0, +)
    }
}

extension Day07 {
    struct Calibration: Equatable, Sendable {
        let target: Int
        let values: [Int]
        
        var isValid: Bool {
            canMakeTarget(target, values: values[...])
        }
        
        var isValidWithConcoatenation: Bool {
            canConcatenate(target, values: values[...])
        }
        
        private func canMakeTarget(_ target: Int, values: Array<Int>.SubSequence) -> Bool {
            var values = values
            guard let nextValue = values.popLast() else { fatalError("Out of bounds") }
            guard values.count > 0 else { return target == nextValue }
            
            let branch1 = target % nextValue == 0 && canMakeTarget(target / nextValue, values: values)
            let branch2 = target > nextValue && canMakeTarget(target - nextValue, values: values)
            
            return branch1 || branch2
        }
        
        private func canConcatenate(_ target: Int, values: Array<Int>.SubSequence) -> Bool {
            var values = values
            guard let nextValue = values.popLast() else { fatalError("Out of bounds") }
            guard values.count > 0 else { return target == nextValue }
            
            let strTarget = String(target)
            let strNextValue = String(nextValue)
            
            let branch1 = target % nextValue == 0 && canConcatenate(target / nextValue, values: values)
            let branch2 = target > nextValue && canConcatenate(target - nextValue, values: values)
            let branch3 = strTarget.count > strNextValue.count
            && strTarget.hasSuffix(strNextValue)
            && canConcatenate(strTarget.remove(strNextValue), values: values)
            
            return branch1 || branch2 || branch3
        }
    }
}

extension Day07 {
    struct CalibrationParser: Parser {
        var body: some Parser<Substring, Calibration> {
            Parse(Calibration.init) {
                Digits()
                ": "
                Many {
                    Digits()
                } separator: {
                    " "
                }
            }
        }
    }
    
    struct CalibrationsParser: Parser {
        var body: some Parser<Substring, [Calibration]> {
            Many {
                CalibrationParser()
            } separator: {
                Whitespace(1..., .vertical)
            } terminator: {
                End()
            }
        }
    }
}

extension String {
    func remove(_ suffix: String) -> Int {
        let suffixLCount = suffix.count
        let newStr = self[..<index(endIndex, offsetBy: -suffixLCount)]
        return Int(newStr)!
    }
}
