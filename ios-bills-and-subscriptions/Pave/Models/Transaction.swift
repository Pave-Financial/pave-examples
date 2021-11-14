//
//  Transactions.swift
//  Pave
//
//  Created by Sailesh Patnala on 11/13/21.
//

import Foundation

struct Transaction {
    let pave_transaction_id: String
    let transaction_id: String
    let name: String
    let date: Date
    let amount: Double
    let triggered_fee: String?
    
    static func fromDTO(_ dto: TransactionsDTO) -> Transaction {
        return Transaction(
            pave_transaction_id: dto.pave_transaction_id,
            transaction_id: dto.transaction_id,
            name: dto.name,
            date: dto.date,
            amount: dto.amount,
            triggered_fee: dto.triggered_fee
        )
    }
}
