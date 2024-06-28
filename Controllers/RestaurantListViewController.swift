import UIKit
import CoreData

class RestaurantListViewController: UITableViewController, UISearchBarDelegate {
    var restaurants: [Restaurant] = []
    var filteredRestaurants: [Restaurant] = []
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupSearchBar()
        setupAddButton()
    }

    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        
        do {
            restaurants = try context.fetch(fetchRequest)
            filteredRestaurants = restaurants
            tableView.reloadData()
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }

    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Restaurants"
        navigationItem.titleView = searchBar
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredRestaurants = searchText.isEmpty ? restaurants : restaurants.filter { (restaurant: Restaurant) -> Bool in
            return restaurant.name?.range(of: searchText, options: .caseInsensitive) != nil
        }
        tableView.reloadData()
    }

    func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRestaurant))
    }

    @objc func addRestaurant() {
        let addVC = AddRestaurantViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
        cell.textLabel?.text = filteredRestaurants[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRestaurant = filteredRestaurants[indexPath.row]
        let detailVC = RestaurantDetailViewController()
        detailVC.restaurant = selectedRestaurant
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RestaurantListViewController: AddRestaurantViewControllerDelegate {
    func didAddRestaurant() {
        fetchData()
    }
}