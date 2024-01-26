module UserCreator
  def self.create_user(name, email, role, company, avatar_file = nil)
    user = User.create!(
      name: name,
      email: email,
      password: '000000',
      password_confirmation: '000000',
      role: role,
      confirmed_at: DateTime.now,
      company: company
    )

    if avatar_file
      user.avatar.attach(
        io: File.open(Rails.root.join('spec', 'support', 'images', avatar_file)),
        filename: avatar_file,
        content_type: 'image/jpg'
      )
    end

    user
  end
end
