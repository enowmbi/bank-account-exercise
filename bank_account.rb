# frozen_string_literal: true

# Basic bank account class
class BankAccount
  @@all = []

  BANK_ACCOUNT_TYPES = %w[saving_account checking_account].freeze
  MIN_ACCOUNT_BALANCE = { saving_account: 1_000, checking_account: 100 }.freeze
  INTEREST_RATE = 2.5

  def initialize(client)
    @client = client
    @account_number = generate_account_number
    @interest_rate = INTEREST_RATE
    @saving_account_balance = 0
    @checking_account_balance = 0
    @@all << self
  end

  def deposit(amount:, account_type:)
    return 'Amount is invalid. Amount should be greater than zero(0)' unless amount_is_valid?(amount)
    return 'Select proper account type' unless account_type_is_valid?(account_type)

    if account_type == 'saving_account'
      @saving_account_balance += amount
    elsif account_type == 'checking_account'
      @checking_account_balance += amount
    end
    amount
  end

  def withdraw(amount:, account_type:)
    return 'Amount is invalid. Amount should be greater than zero(0)' unless amount_is_valid?(amount)
    return 'Select proper account type' unless account_type_is_valid?(account_type)

    if account_type == 'saving_account'
      return 'Insufficient funds in saving account' unless withdrawal_possible?(amount: amount, account_type: account_type)

      @saving_account_balance -= amount
    elsif account_type == 'checking_account'
      return 'Insufficient funds in checking account' unless withdrawal_possible?(amount: amount, account_type: account_type)

      @checking_account_balance -= amount
    end
    amount
  end

  def account_balance
    {
      saving_account_balance: saving_account_balance,
      checking_account_balance: checking_account_balance,
      total_balance: saving_account_balance + checking_account_balance
    }
  end

  def self.number_of_accounts
    @@all.size
  end

  def account_information
    {
      client: client,
      account_number: account_number,
      interest_rate: interest_rate,
      account_balance: account_balance
    }
  end

  def self.all
    @@all
  end

  private

  attr_reader :interest_rate

  def generate_account_number
    rand(10**23)
  end

  def amount_is_valid?(amount)
    amount.positive?
  end

  def account_type_is_valid?(account_type)
    BANK_ACCOUNT_TYPES.include?(account_type)
  end

  def withdrawal_possible?(amount:, account_type:)
    if account_type == 'saving_account'
      account_balance = @saving_account_balance
    elsif account_type == 'checking_account'
      account_balance = @checking_account_balance
    end
    MIN_ACCOUNT_BALANCE[account_type.to_sym] < (account_balance - amount)
  end
end
