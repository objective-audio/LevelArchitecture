//
//  AccountRepository.swift
//

import Foundation

final class AccountRepository {
    private weak var userDefaults: UserDefaults?
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var accounts: [Account] {
        self.userDefaults?.accounts.compactMap(Account.init) ?? []
    }
    
    func account(forId id: Int) -> Account? {
        self.accounts.first { $0.id == id }
    }
    
    func append(account: Account) {
        let accounts = self.accounts + [account]
        self.userDefaults?.accounts = accounts.map { $0.dictionary }
    }
    
    func remove(accountId: Int) {
        var accounts = self.accounts
        accounts.removeAll { $0.id == accountId }
        self.userDefaults?.accounts = accounts.map { $0.dictionary }
    }
    
    func update(account: Account) {
        let accounts = self.accounts.map { $0.id == account.id ? account : $0 }
        self.userDefaults?.accounts = accounts.map { $0.dictionary }
    }
}

private extension Account {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary[Key.id] as? Int,
              let name = dictionary[Key.name] as? String else {
            assertionFailureIfNotTest()
            return nil
        }
        
        self.id = id
        self.name = name
    }
    
    var dictionary: [String: Any] {
        [Key.id: self.id,
         Key.name: self.name]
    }
}

private extension Account {
    enum Key {
        static let id = "id"
        static let name = "name"
    }
}
