/// Utility functions for GST calculations in the GST Billing App.

/// Calculates CGST for a given price and GST rate.
double calculateCGST(double price, double gstRate) {
  return (price * gstRate / 100) / 2;
}

/// Calculates SGST for a given price and GST rate.
double calculateSGST(double price, double gstRate) {
  return (price * gstRate / 100) / 2;
}

/// Calculates total price including GST for a given price and GST rate.
double calculateTotalPrice(double price, double gstRate) {
  final cgst = calculateCGST(price, gstRate);
  final sgst = calculateSGST(price, gstRate);
  return price + cgst + sgst;
}
