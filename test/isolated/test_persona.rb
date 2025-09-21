$: << File.join(File.dirname(__FILE__), '..')

require 'helper'

begin
  require 'rails/all'
rescue LoadError => e
  puts "Rails are not in the gemfile, skipping tests"
  Process.exit
end

Oj.default_options = {
  # If true dump BigDecimal as a decimal number otherwise as a String
  bigdecimal_as_decimal: true,
  # Returns a BigDecimal or Float depending on what's the most precise
  # for the number of digits is used
  bigdecimal_load: :auto,
  compat_bigdecimal: :auto,
}
Oj.optimize_rails

# require 'isolated/shared'

# $rails_monkey = true

class Persona < Minitest::Test
  def test_persona_bigdecimal
    bd = BigDecimal('1.12345678912345678912345')

    json_string = '{"amount": 1.12345678912345678912345, "float": 1.23}'
    parsed = JSON.parse(json_string)

    assert_equal bd, parsed['amount']
    assert_kind_of BigDecimal, parsed['amount']
  end

  def test_persona_float
    bd = BigDecimal('1.12345678912345678912345')

    json_string = '{"amount": 1.12345678912345678912345, "float": 1.23}'
    parsed = JSON.parse(json_string)

    assert_equal 1.23, parsed['float']
    assert_kind_of Float, parsed['float']
  end
end # Persona
