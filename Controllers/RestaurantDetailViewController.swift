import UIKit

class RestaurantDetailViewController: UIViewController {

    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        guard let restaurant = restaurant else { return }

        title = restaurant.name

        let nameLabel = UILabel()
        nameLabel.text = "Name: \(restaurant.name ?? "")"

        let addressLabel = UILabel()
        addressLabel.text = "Address: \(restaurant.address ?? "")"

        let detailsLabel = UILabel()
        detailsLabel.text = "Happy Hour Details: \(restaurant.happyHourDetails ?? "")"

        let stackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel, detailsLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}