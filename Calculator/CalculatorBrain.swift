//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Reyhan Sofian on 6/3/17.
//  Copyright © 2017 Reyhan Sofian. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private var accumulator = 0.0
    
    private var operations: Dictionary<String, Operations> = [
        "π": Operations.Constant(M_PI),
        "e": Operations.Constant(M_E),
        "√": Operations.UnaryOperation(sqrt),
        "±": Operations.UnaryOperation({ -$0 }),
        "cos": Operations.UnaryOperation(cos),
        "×": Operations.BinaryOperation({ $0 * $1 }),
        "+": Operations.BinaryOperation({ $0 + $1 }),
        "-": Operations.BinaryOperation({ $0 - $1 }),
        "÷": Operations.BinaryOperation({ $0 / $1 }),
        "=": Operations.Equals
    ]
    
    
    private enum Operations {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let val): accumulator = val
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
