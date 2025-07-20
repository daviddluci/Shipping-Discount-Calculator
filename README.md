
# Shipping Discount Calculator - Backend Homework Assignment

A Ruby application that calculates shipment discounts based on package size, carrier, and monthly discount limits.

  

## ✨ Features

- Parses lines from a text file in format `YYYY-MM PackageSize CarrierName`.
- Correctly matches lowest price for shipment of size 'S' across all carriers.
- Correctly sets the third 'L' size shipment via LP carrier to `free`, but only once a calendar month.
- Correctly applies monthly discount limits to ensure maximum discounts are respected.

## 📋 Requirements

- Ruby 3.4+

- Bundler (for managing gems)

## 📦 Gems Used

  

-  `rake` - Runs automated tasks like tests or setup scripts.

-  `minitest` - Used for writing and running **unit tests**.

## ⚙️ Setup

  

1.  **Clone this repository**:

  

```bash
git clone https://github.com/daviddluci/Shipping-Discount-Calculator.git

cd Shipping-Discount-Calculator
```

  

2.  **Install dependencies**:

  

Make sure you have **Bundler** installed:

  

```bash

gem install bundler

```

  

Then install the required gems:

  

```bash

bundle install

```

  

## 🚀 Usage

### Running the application
#### All input files are located in the `data/` directory.

- Run the program using default input file - `data/input.txt`
```bash
rake
```

- Run the program using specific input file:

```bash
rake run data/input_1.txt
```

- Run all input files one-by-one
```bash
rake run_all
```

### Running tests
#### All test cases are located in the `test/` directory.
- Run all unit tests:
```bash
rake run_tests
```
*All tests were written using **Minitest**.*

## 📁 Project Structure

- `data/` - Input files
- `lib/` - Ruby source files
- `test/` - Minitest test files
- `Gemfile` - Defines used gems
- `Rakefile` - Custom tasks to run the app
- `main.rb` - Entry point of the application

# ✅ All set!
## ✨ Thank you for checking out this project! ✨