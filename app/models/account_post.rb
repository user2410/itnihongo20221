class AccountPost < ApplicationRecord
  belongs_to :account
  belongs_to :post

  after_create :set_default_like

  def set_default_like
    self.update_attribute(:reaction, 1)
  end
end
