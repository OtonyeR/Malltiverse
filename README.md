# Malltiverse

**Malltiverse** is a Flutter-based mobile application that provides a seamless shopping experience, allowing users to browse and purchase products from various categories.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [API Integration](#api-integration)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- Browse products from various categories
- View product details including images, descriptions, and prices
- Add products to the cart
- Manage the shopping cart
- Place orders

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Dart](https://dart.dev/get-dart)
- An IDE like [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/malltiverse.git
   ```

2. **Navigate to the project directory**

   ```bash
   cd malltiverse
   ```

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

## Usage

### Running the App

1. Connect a device or start an emulator.
2. Run the following command:

   ```bash
   flutter run
   ```

### Navigating the App

- **Home Screen**: Browse products by categories.
- **Product Details**: Tap on a product to view its details.
- **Cart**: Add products to the cart and manage them.
- **Checkout**: Place orders for the products in the cart.

## API Integration

Malltiverse integrates with the Timbu API to fetch product data. The API service is located in `lib/services/api_services.dart`.

## Project Structure

```plaintext
lib/
├── components/
│   ├── widgets/
│   │   └── product_tile.dart
├── models/
│   ├── cart.dart
│   └── product.dart
├── services/
│   └── api_services.dart
├── ui/
│   ├── colors.dart
│   ├── home/
│   │   └── home_screen.dart
│   └── product/
│       └── product_details_screen.dart
└── main.dart
```

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

- **Your Name** - [otonye.robinson7@stu.cu.edu.ng](mailto:otonye.robinson7@stu.cu.edu.ng)
- **GitHub** - [OtonyeR](https://github.com/OtonyeR)
