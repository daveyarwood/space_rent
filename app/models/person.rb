class Person < ActiveRecord::Base
  has_many :messages
  has_secure_password

  validates_presence_of :name, :email
  validates_uniqueness_of :name, case_sensitive: false
  validates_format_of :email, with: /.+@.+/
  
  before_create :create_remember_token
  
  def Person.ci_search!(name)
    # Does a case-insensitive search for a person named `name`. Returns the
    # first (only) result or throws an ActiveRecord::RecordNotFound error. 
    find_by!(arel_table[:name].matches(name))
  end
  
  def authenticate!(pw)
    # Same as authenticate, but throws an ActiveRecord::AuthenticationError
    # (instead of returning false) if the password doesn't check out.
    authenticate(pw) or raise ActiveRecord::AuthenticationError
  end
  
  def Person.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def Person.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
  def create_remember_token
    self.remember_token = Person.digest(Person.new_remember_token)
  end
end