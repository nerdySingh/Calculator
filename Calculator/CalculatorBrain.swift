//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Tanveer Anand on 27/05/17.
//  Copyright © 2017 Tanveer Anand. All rights reserved.
//
import Foundation
func changeSign(operand:Double)->Double
{
    return -operand
}

func multiply(op1:Double, op2:Double)->Double
{
    return op1 * op2
}
struct CalculatorBrain
{
    public var myval:Double?
    private var accumulator:Double?
    private enum Operation
    {
        case constant(Double)
        case unaryOperator((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    private var operationsConstants:Dictionary<String,Operation> =
    [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperator(sqrt),
        "cos" : Operation.unaryOperator(cos),
        "±" : Operation.unaryOperator(changeSign),
        "×" : Operation.binaryOperation({$0 * $1}), //this is a closure ie a function can be called within a line in swift dont need to write code for it externally.
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "−" : Operation.binaryOperation({ $0 - $1 }),
        "=" : Operation.equals
    ]
    mutating func performOperation(_ symbol: String)
    {
        if let constant = operationsConstants[symbol]
        {
            switch constant
            {
                case .constant(let value):
                    print(value)
                    accumulator = value
                
                case .unaryOperator(let function):
                    if accumulator != nil
                    {
                        accumulator = function(accumulator!)
                    }
                case .binaryOperation(let function):
                    
                    print(accumulator!)
                    if accumulator != nil
                    {
                        pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                        print(pbo!)
                        accumulator = nil
                    }
                
                case .equals:
                    performPendingBinaryOperation()
            }
        }
    }
private var pbo: PendingBinaryOperation?

private mutating func performPendingBinaryOperation()
{
        if pbo != nil && accumulator != nil
        {
            accumulator = pbo?.perform(with: accumulator!)
            pbo = nil
        }
}

private struct PendingBinaryOperation
    {
        let function:(Double,Double)->Double
        let firstOperand : Double
    
        func perform(with secondOperand:Double)->Double
        {
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double)
    {
        accumulator = operand
    }
    
    var result:Double?
    {
        get
        {
            return accumulator
        }
    }
}
