//
//  LoggedInView.swift
//  Firebase Login
//
//  Created by Burak Güner on 26.02.2023.
//

import SwiftUI

struct LoggedInView: View {
	@EnvironmentObject var loginModel: LoginModel
	var body: some View {
		VStack {
			Text("You have successfully logged in ✨")
			CustomButton(title: "Log Out") {
				loginModel.logout()
			}.padding(.horizontal).padding(.top)
		}
	}
}

struct LoggedInView_Previews: PreviewProvider {
	static var previews: some View {
		LoggedInView()
			.environmentObject(LoginModel())
	}
}
