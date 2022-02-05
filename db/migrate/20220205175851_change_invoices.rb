class ChangeInvoices < ActiveRecord::Migration[7.0]
  # Pela descrição dos campos na issue#33 achei melhor alterar nome/tipo dos campos
  def change
    remove_column :invoices, :customer_name
    remove_column :invoices, :customer_notes

    add_column :invoices, :invoice_from, :text
    add_column :invoices, :invoice_to, :text
  end
end
