import Combine
import Foundation

class LoginModel: ObservableObject {
	@Published var loginData: Login?

	@Published var showCredientalsIncorrectError = false
	@Published var loading = false
	@Published var saveCredientals = false

	private var cancelables: [AnyCancellable] = []

	var isLoggedIn: Bool {
		return loginData?.idToken != nil
	}

	func logout() {
		loginData = nil
		showCredientalsIncorrectError = false
		loading = false
	}

	func login(email: String, password: String) {
		loading = true
		let url = URL(
			string:
				"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=YOUR_FIREBASE_KEY_HERE"
		)!
		var request = URLRequest(url: url)

		let headers = [
			"Accept": "*/*",
			"Content-Type": "application/json",
		]
		let parameters: [String: Any] = [
			"email": email,
			"password": password,
		]
		request.httpMethod = "POST"
		request.allHTTPHeaderFields = headers
		request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

		let task = URLSession.shared.dataTask(with: request) { data, response, error in

			if error != nil {
				// Handle error
			}
			guard let httpResponse = response as? HTTPURLResponse else { return }

			if (200...299).contains(httpResponse.statusCode) {
				// Status is OK, continue
				let result = try! JSONDecoder().decode(Login.self, from: data!)
				DispatchQueue.main.async {
					self.showCredientalsIncorrectError = false
					self.loginData = result
				}
			} else {
				// Status is not OK, handle error
				let dataString = String(decoding: data!, as: UTF8.self)
				DispatchQueue.main.async {
					self.showCredientalsIncorrectError = true
				}
				print(dataString)
			}

			DispatchQueue.main.async {
				self.loading = false
			}
		}
		task.resume()
	}

	init() {
		let loadedValue = Login.loadFromKeychain()

		switch loadedValue {
		case .success(let loadedLogin):
			self.loginData = loadedLogin

		case .failure(let error):
			print(error)
		}

		$loginData.sink { value in
            if let value {
                if(self.saveCredientals){
                    _ = value.saveToKeychain()
                }
            } else {
                Login.clearKeychain()
            }
		}.store(in: &cancelables)

	}

	/// This is used to see the error state on previews.
	/// Please Don't use this outside of a preview.
	init(showCredientalsIncorrectError: Bool) {
		self.showCredientalsIncorrectError = showCredientalsIncorrectError
	}
}
