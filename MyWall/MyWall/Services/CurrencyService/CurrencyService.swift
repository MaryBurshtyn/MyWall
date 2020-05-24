import Foundation

class CurrencyService: CurrencyServiceProtocol {
    
    private let urlString = "http://data.fixer.io/api/latest?access_key=dfaee6bd149336e659121c6cd8313a28&symbols=USD,BYN,UAH,RUB"
    
    private var bynRate: Float? {
        guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.bynRate) else {
            return nil
        }
        return Float(stringValue)
    }
    private var usdRate: Float? {
        guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.usdRate) else {
            return nil
        }
        return Float(stringValue)
    }
    private var uahRate: Float? {
        guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.uahRate) else {
            return nil
        }
        return Float(stringValue)
    }
    private var rubRate: Float? {
        guard let stringValue = UserDefaults.standard.string(forKey: AppConstants.rubRate) else {
            return nil
        }
        return Float(stringValue)
    }
    
    func makeRequest() {
        let url = URL(string: urlString)
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            if let error = error {
                log.error("Error took place \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                log.info("Response HTTP Status code: \(response.statusCode)")
            }
            if let data = data {
                self?.parseResponse(data)
            }
        }
        task.resume()
    }
    
    private func parseResponse(_ data: Data) {
        do {
             let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            guard let dict = json,
            let arr = dict["rates"] as? [String : Any],
            let byn = arr["BYN"] as? Double,
            let rub = arr["RUB"] as? Double,
            let usd = arr["USD"] as? Double,
            let uah = arr["UAH"] as? Double else {
                return
            }
            UserDefaults.standard.set(String(byn), forKey: AppConstants.bynRate)
            UserDefaults.standard.set(String(rub), forKey: AppConstants.rubRate)
            UserDefaults.standard.set(String(usd), forKey: AppConstants.usdRate)
            UserDefaults.standard.set(String(uah), forKey: AppConstants.uahRate)
        } catch {
            log.error("Couldnt parse obj")
        }
    }
    
    func getBynRate() -> Float? {
       return bynRate
    }

    func getUsdRate() -> Float? {
       return usdRate
    }

    func getUahRate() -> Float? {
       return uahRate
    }

    func getRubRate() -> Float? {
       return rubRate
    }
    
    func convert(from: Currency, to: Currency, value: Float) -> Float {
        return to.rate * value / from.rate
    }
    
}
