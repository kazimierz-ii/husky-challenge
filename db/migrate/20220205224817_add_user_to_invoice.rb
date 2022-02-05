class AddUserToInvoice < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :user, index: true
  end
end
