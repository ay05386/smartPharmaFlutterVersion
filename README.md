
Smart Pharma (Flutter)

A cross-platform mobile application for pharmacies, built with Flutter and Dart. This app allows users to manage their pharmacy inventory, track medicine sales, and monitor low-stock items efficiently.

Features
- User Authentication: Simple sign-up and login flow with local database validation.
- Inventory Management: Add, update, delete medicines and track their details, including name, price, quantity, and more.
- Sales Tracking: Monitor the most sold items and low-stock medicines using real-time database queries.
- Local Database: Uses sqflite for offline storage and data persistence.
- Intuitive UI: Clean and responsive user interface built with Flutter’s widget system.

Technologies Used
- Flutter & Dart: Front-end framework and programming language.
- sqflite: Local database to manage user and medicine data.
- MVVM Architecture: Ensures clean and maintainable code.
- Material Design: Provides a modern and responsive user experience.

Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/smart-pharma-flutter.git
    ```

2. Navigate to the project directory:
    ```bash
    cd smart-pharma-flutter
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app:
    ```bash
    flutter run
    ```

> Note: Ensure you have Flutter installed on your machine. [Install Flutter](https://flutter.dev/docs/get-started/install)

Project Structure

- lib/database: Contains local database logic, including methods for user and medicine management.
- lib/models: Data models for users and medicines.
- lib/screens: UI screens like Login, SignUp, Home, and Stock.
- lib/widgets: Reusable UI components.
  
How to Use

1. Login / Sign Up: Create a user account or log in with existing credentials.
2. Add Medicines: Navigate to the 'Add Medicine' screen to insert medicine details into the database.
3. View Inventory: See a list of all medicines with their current stock levels and sales data.
4. Track Low Stock / Sales: The home page highlights low-quantity and most-sold items.

Future Enhancements

- Cloud Sync: Sync data with a cloud-based service for real-time updates across devices.
- Push Notifications: Notify users when medicine quantities fall below a certain threshold.
- AI Integration: Further enhance the app by adding AI features for advanced prescription management.

Contributing

Feel free to fork the repository and submit pull requests. Contributions, suggestions, and improvements are always welcome!

License

This project is licensed under the MIT License - see the LICENSE file for details.

Contact

For any inquiries or support, please reach out to me at:
- Email: ay05386@gmail.com
- LinkedIn: [Ali Youssef](https://www.linkedin.com/in/ali-youssef-4a4616239/)
- GitHub: [ay05386](https://github.com/ay05386)

---

This version removes the bold formatting, while keeping the content clear and easy to follow.
