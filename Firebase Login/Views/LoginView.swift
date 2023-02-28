import SwiftUI

struct LoginView: View {
	@State private var email = ""
	@State private var password = ""

	@EnvironmentObject var loginModel: LoginModel

	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text("Let's Sign You In").font(.largeTitle).fontWeight(
						.bold
					).padding(.bottom)
					Text("Welcome back,\nYou've been missed").font(.title)
				}
				.padding(.leading)
				Spacer()

			}
			VStack(spacing: 10.0) {
				CustomTextField(title: "Email", text: $email).keyboardType(
					.emailAddress
				).textContentType(
					.emailAddress)
				CustomSecureField(title: "Password", text: $password)
			}
			.padding()

			Toggle(isOn: $loginModel.saveCredientals) {
				Text("Remember me")
			}
			.padding(.horizontal)

			CustomButton(title: "Sign In", showLoadingIndicator: $loginModel.loading) {
				loginModel.login(email: email, password: password)
			}
			.padding(.horizontal)

			if loginModel.showCredientalsIncorrectError {
				Text("Username or password is incorrect")
					.foregroundColor(.red)
					.padding(.top)
			}
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			LoginView().environmentObject(LoginModel())
				.previewDisplayName("Initial")
			LoginView()
				.environmentObject(LoginModel(showCredientalsIncorrectError: true))
				.previewDisplayName("Error")
		}

	}
}
