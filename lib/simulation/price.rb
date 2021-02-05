MIN_PRICE = 0.01

def price_curve(buys:, sells:, volatility:, speed:)
  delta = speed * (buys - sells)
  direction = (2 / (1 + Math.exp(-delta))) - 1
  return volatility * direction
end
