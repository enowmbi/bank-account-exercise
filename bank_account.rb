# frozen_string_literal: true

# This is bank account class
class BankAccount
  attr_reader :account_number, :account_type, :balance, :client_name

  ACCOUNT_TYPES = {checking: 0, saving: 1}

  def initialize(account_type: ACCOUNT_TYPES[:checking], initial_deposit: 0, client_name:)
    @account_type = account_type
    @balance = initial_deposit
    @client_name = client_name
    @account_number = generate_account_number
  end

  private

  def generate_account_number
    rand(10).to_s[2..16]
  end
end
