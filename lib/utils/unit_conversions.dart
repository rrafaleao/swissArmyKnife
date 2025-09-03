double convertUnit(double value, String fromUnit, String toUnit, String unitType) {
  // Conversões de comprimento
  if (unitType == 'Length') {
    // Converter para metros primeiro
    double valueInMeters;
    switch (fromUnit) {
      case 'Meters':
        valueInMeters = value;
        break;
      case 'Kilometers':
        valueInMeters = value * 1000;
        break;
      case 'Centimeters':
        valueInMeters = value / 100;
        break;
      case 'Millimeters':
        valueInMeters = value / 1000;
        break;
      case 'Miles':
        valueInMeters = value * 1609.34;
        break;
      case 'Yards':
        valueInMeters = value * 0.9144;
        break;
      case 'Feet':
        valueInMeters = value * 0.3048;
        break;
      case 'Inches':
        valueInMeters = value * 0.0254;
        break;
      default:
        valueInMeters = value;
    }

    // Converter de metros para a unidade de destino
    switch (toUnit) {
      case 'Meters':
        return valueInMeters;
      case 'Kilometers':
        return valueInMeters / 1000;
      case 'Centimeters':
        return valueInMeters * 100;
      case 'Millimeters':
        return valueInMeters * 1000;
      case 'Miles':
        return valueInMeters / 1609.34;
      case 'Yards':
        return valueInMeters / 0.9144;
      case 'Feet':
        return valueInMeters / 0.3048;
      case 'Inches':
        return valueInMeters / 0.0254;
      default:
        return valueInMeters;
    }
  }

  // Conversões de peso
  else if (unitType == 'Weight') {
    // Converter para gramas primeiro
    double valueInGrams;
    switch (fromUnit) {
      case 'Grams':
        valueInGrams = value;
        break;
      case 'Kilograms':
        valueInGrams = value * 1000;
        break;
      case 'Milligrams':
        valueInGrams = value / 1000;
        break;
      case 'Pounds':
        valueInGrams = value * 453.592;
        break;
      case 'Ounces':
        valueInGrams = value * 28.3495;
        break;
      default:
        valueInGrams = value;
    }

    // Converter de gramas para a unidade de destino
    switch (toUnit) {
      case 'Grams':
        return valueInGrams;
      case 'Kilograms':
        return valueInGrams / 1000;
      case 'Milligrams':
        return valueInGrams * 1000;
      case 'Pounds':
        return valueInGrams / 453.592;
      case 'Ounces':
        return valueInGrams / 28.3495;
      default:
        return valueInGrams;
    }
  }

  // Conversões de temperatura
  else if (unitType == 'Temperature') {
    // Converter para Celsius primeiro
    double valueInCelsius;
    switch (fromUnit) {
      case 'Celsius':
        valueInCelsius = value;
        break;
      case 'Fahrenheit':
        valueInCelsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        valueInCelsius = value - 273.15;
        break;
      default:
        valueInCelsius = value;
    }

    // Converter de Celsius para a unidade de destino
    switch (toUnit) {
      case 'Celsius':
        return valueInCelsius;
      case 'Fahrenheit':
        return (valueInCelsius * 9 / 5) + 32;
      case 'Kelvin':
        return valueInCelsius + 273.15;
      default:
        return valueInCelsius;
    }
  }

  // Conversões de volume
  else if (unitType == 'Volume') {
    // Converter para litros primeiro
    double valueInLiters;
    switch (fromUnit) {
      case 'Liters':
        valueInLiters = value;
        break;
      case 'Milliliters':
        valueInLiters = value / 1000;
        break;
      case 'Gallons':
        valueInLiters = value * 3.78541;
        break;
      case 'Quarts':
        valueInLiters = value * 0.946353;
        break;
      case 'Pints':
        valueInLiters = value * 0.473176;
        break;
      case 'Cups':
        valueInLiters = value * 0.24;
        break;
      default:
        valueInLiters = value;
    }

    // Converter de litros para a unidade de destino
    switch (toUnit) {
      case 'Liters':
        return valueInLiters;
      case 'Milliliters':
        return valueInLiters * 1000;
      case 'Gallons':
        return valueInLiters / 3.78541;
      case 'Quarts':
        return valueInLiters / 0.946353;
      case 'Pints':
        return valueInLiters / 0.473176;
      case 'Cups':
        return valueInLiters / 0.24;
      default:
        return valueInLiters;
    }
  }

  return value;
}