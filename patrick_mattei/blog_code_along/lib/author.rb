class Author
  attr_accessor :first_name, :last_name, :email

  def full_name
    "#{first_name}  #{last_name}"
  end
end
