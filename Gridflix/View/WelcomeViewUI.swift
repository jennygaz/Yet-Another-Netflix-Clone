//
//  WelcomeViewUI.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 30/09/24.
//

import SwiftUI

struct WelcomeViewUI: View {
    var privacyAction: (() -> Void)?
    var signInAction: (() -> Void)?
    var registerAction: (() -> Void)?

    var body: some View {
        ZStack(alignment: .center) {
            Color.black.ignoresSafeArea(.container, edges: .all)
            Image("WelcomeImage")
                .ignoresSafeArea(.container, edges: .all)
            gradientMask
            VStack {
                topBarContainer
                Spacer()
                VStack {
                    welcomeText
                    registerButton
                }
            }
        }
    }
}

private extension WelcomeViewUI {
    var topBarContainer: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("netflix_n_logo")
            Spacer()
            Button("Privacy") { privacyAction?() }
            Button("Sign In") { signInAction?() }
        }
        .font(.headline)
        .buttonStyle(.borderless)
        .tint(.white.opacity(0.7))
        .padding(.trailing, 16)
        .padding(.bottom, 10)
        .background(Color.black)
    }

    var gradientMask: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(
                    color: Color(red: 47.0 / 255.0, green: 76.0 / 255.0, blue: 233.0 / 255.0, opacity: 0.0),
                    location: 0.7),
                Gradient.Stop(
                    color: Color(red: 0.0, green: 4.0 / 255.0, blue: 105.0 / 255.0, opacity: 1.0),
                    location: 1.0)],
            startPoint: .top,
            endPoint: .bottom)
    }

    var registerButton: some View {
        Button {
            registerAction?()
        } label: {
            Text("Get Started")
                .font(.title.weight(.medium))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding(.vertical, 8)
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .padding(.horizontal)
        .padding(.bottom)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }

    var welcomeText: some View {
        Text("Unlimited movies, TV shows & more")
            .multilineTextAlignment(.center)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 80)
    }
}

#Preview {
    WelcomeViewUI(
        privacyAction: { print("Privacy") },
        signInAction: { print("sign in") },
        registerAction: { print("register") })
}
