import UIKit
import CoreData

protocol AddRestaurantViewControllerDelegate: AnyObject {
    func didAddRestaurant()
}

class AddRestaurantViewController: UIViewController {

    weak var delegate: AddRestaurantViewControllerDelegate?

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Restaurant Name"
        return textField
    }()

    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Address"
        return textField
    }()

    let detailsTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Happy Hour Details"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupSaveButton()
    }

    func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, addressTextField, detailsTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveRestaurant))
    }

    @objc func saveRestaurant() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let restaurant = Restaurant(context: context)
        restaurant.name = nameTextField.text
        restaurant.address = addressTextField.text
        restaurant.happyHourDetails = detailsTextField.text

        do {
            try context.save()
            delegate?.didAddRestaurant()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save restaurant: \(error)")
        }
    }
}