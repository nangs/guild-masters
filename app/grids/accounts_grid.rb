class AccountsGrid
  include Datagrid

  scope do
    Account
  end

  filter(:username, :string) { |value| where("username like '%#{value}%'") }
  filter(:email, :string) { |value| where("email like '%#{value}%'") }
  filter(:num_failed_attempts, :integer, range: true)

  column(:username, mandatory: true)
  column(:email, mandatory: true)
  column(:num_failed_attempts, mandatory: true)
  column(:is_admin, mandatory: true)
  column(:is_logged_in, mandatory: true)


  column(:actions, html: true, mandatory: true) do |account|
    link_to 'Edit', edit_admin_account_path(account)
  end

  column(:actions, html: true, mandatory: true) do |account|
    link_to 'Delete', admin_account_path(account), method: :delete, data: { confirm: 'Are you sure?' }
  end
end
