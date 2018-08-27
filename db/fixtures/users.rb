User.seed(:id,
  { id: 1, email: 'admin@email.com',   password: 'qwerty', password_confirmation: 'qwerty' },
  { id: 2, email: 'emily@example.com', password: 'qwerty', password_confirmation: 'qwerty' },
)
User.all.map(&:confirm)
User.first.add_role :admin
