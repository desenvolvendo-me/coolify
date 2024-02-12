module UserCreator
  def self.create_user(name, email, role, company, options = {})
    user_params = {
      name: name,
      email: email,
      password: '000000',
      password_confirmation: '000000',
      role: role,
      confirmed_at: DateTime.now,
      company: company
    }
    user_params[:cft] = options[:cft] if options[:cft].present?

    user = User.create!(user_params)

    attach_avatar(user, options[:avatar_file]) if options[:avatar_file]

    user
  end

  def self.attach_avatar(user, avatar_file)
    user.avatar.attach(
      io: File.open(Rails.root.join('spec', 'support', 'images', avatar_file)),
      filename: avatar_file,
      content_type: 'image/jpg'
    )
  end
end
