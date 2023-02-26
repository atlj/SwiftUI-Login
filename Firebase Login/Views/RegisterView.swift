import SwiftUI

struct RegisterView: View {
	@State private var email = ""
	@State private var password = ""
	@State private var passwordCopy = ""
	@State private var loginModalShown = false

	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text("Let's Register\nThis Account").font(.largeTitle)
						.fontWeight(.bold).padding(.bottom)
					Text("Hello user, you have\na greatful journey").font(
						.title)
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
				CustomSecureField(title: "Password Again", text: $passwordCopy)
			}
			.padding()

			CustomButton(title: "Register") {
				print("register")
			}
			.padding(.horizontal)

			HStack(spacing: 0.0) {
				Text("Already have an account? ")
				Button {
					let impactGenerator = UIImpactFeedbackGenerator(
						style: .medium)
					loginModalShown.toggle()
					impactGenerator.impactOccurred()
				} label: {
					Text("Login")
						.fontWeight(.bold)
						.foregroundColor(.primary)
				}
			}
			.padding(.top)
		}
		.sheet(isPresented: $loginModalShown) {
			LoginView()
		}
	}
}

struct RegisterView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterView()
	}
}
