//
//  Route.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 20/09/24.
//

enum Route {
    case launch
    case landing
    case signUp
    case signIn
    case onboarding
    case profileSelection
    case tab(Void)
    case detail(Void)
    case player(Void)
}

/*
 Route Map:
 * Launch -> Landing
 * Landing -> [Sign Up, Sign In]
 * Sign Up -> Onboarding
 * Onboarding -> Profile Selection
 * Sign In -> Profile Selection
 * Profile Selection <- p -> [.Add, .Edit, .Delete] // p = push & pop based
 * Profile Selection -> Tab
 * Tab -> Landing
 * Tab <- s -> [.Home, .Games, .News, .Profile] // s = switch between
 * [.Profile] <- p -> ..Downloads
 * [.Home, .Games, .News, ..Downloads] <- p -> [..Detail]
 * [.Home, .Games, .News, ..Downloads, ..Detail] p -> ..EntityPlayer
 */
