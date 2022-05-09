//
//  AccountMenuInteractorDependencies.swift
//

protocol AccountNavigationLifeCycleForAccountMenuInteractor: AnyObject {
    var canPushInfo: Bool { get }
    func pushInfo(uiSystem: UISystem)
}

protocol ActionSenderForAccountMenuInteractor: AnyObject {
    func sendLogout(accountLifetimeId: AccountLifetimeId)
}
