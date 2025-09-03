// Utilitário para conversão de moedas com taxas fixas (para demonstração)
Map<String, dynamic> convertCurrency(double amount, String fromCurrency, String toCurrency) {
  // Taxas de câmbio fixas (valores fictícios para demonstração)
  final Map<String, double> exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.0,
    'AUD': 1.35,
    'CAD': 1.25,
    'CHF': 0.92,
    'CNY': 6.45,
    'BRL': 5.30,
    'MXN': 20.0,
    'INR': 74.0,
    'RUB': 73.0,
    'KRW': 1150.0,
    'TRY': 8.5,
    'SAR': 3.75,
    'AED': 3.67,
  };
  
  if (!exchangeRates.containsKey(fromCurrency) || !exchangeRates.containsKey(toCurrency)) {
    throw Exception('Moeda não suportada');
  }
  
  // Converter para USD primeiro (moeda base), depois para a moeda de destino
  double amountInUSD = amount / exchangeRates[fromCurrency]!;
  double convertedAmount = amountInUSD * exchangeRates[toCurrency]!;
  double rate = exchangeRates[toCurrency]! / exchangeRates[fromCurrency]!;
  
  return {
    'convertedAmount': convertedAmount,
    'rate': rate,
  };
}