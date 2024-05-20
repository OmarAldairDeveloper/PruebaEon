import Foundation

class ServiceManager {
    static let shared = ServiceManager()
    
    private init() {}
    
    func fetchRandomMeal(completion: @escaping (Result<MealResponse, Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/random.php"
        
        guard let url = URL(string: urlString) else {
            let urlError = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(urlError))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCodeError = NSError(domain: "Invalid response", code: 0, userInfo: nil)
                completion(.failure(statusCodeError))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mealResponse = try decoder.decode(MealResponse.self, from: data)
                completion(.success(mealResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchMealsFor(category: String, completion: @escaping (Result<ReduceMealResponse, Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        
        guard let url = URL(string: urlString) else {
            let urlError = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(.failure(urlError))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCodeError = NSError(domain: "Invalid response", code: 0, userInfo: nil)
                completion(.failure(statusCodeError))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "No data received", code: 0, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mealResponse = try decoder.decode(ReduceMealResponse.self, from: data)
                completion(.success(mealResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchCategories(completion: @escaping (Result<CategoryResponse, Error>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let categoryResponse = try decoder.decode(CategoryResponse.self, from: data)
                completion(.success(categoryResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMealDetails(by id: String, completion: @escaping (Result<MealResponse, Error>) -> Void) {
          guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
              completion(.failure(ServiceError.invalidURL))
              return
          }
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              if let error = error {
                  completion(.failure(error))
                  return
              }
              
              guard let data = data else {
                  completion(.failure(ServiceError.noData))
                  return
              }
              
              do {
                  let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                  let mealResponse = try decoder.decode(MealResponse.self, from: data)
                  completion(.success(mealResponse))
              } catch {
                  completion(.failure(error))
              }
          }.resume()
      }
}
