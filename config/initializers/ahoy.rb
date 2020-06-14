class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = false
# Trying to use below resulted in "undefined method `encode' for 13234779136959091155:Integer"
# Ahoy.token_generator = -> { Druuid.gen }
