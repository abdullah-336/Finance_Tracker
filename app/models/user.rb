class User < ApplicationRecord
  has_many :user_stockings
  has_many :stocks, through: :user_stockings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validates :first_name, presence:true
  # validates :last_name, presence:true  
  def stock_already_tracked?(ticket_symbol)
    stock = Stock.check_db(ticket_symbol)
    return false unless stock
    user_stockings.where(stock_id: stock.id).exists?
  end
  def under_stock_limit?
    stocks.count<10
  end
  def can_track_stock?(ticket_symbol)
    under_stock_limit? && !stock_already_tracked?(ticket_symbol)
  end   
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  
  # def can_add_stock?(ticket_symbol)
  #   under_stock_limit? && !stock_already_added?(ticket_symbol)
  # end
  
  # def under_stock_limit?
  #   (user_stockings.count < 10)
  # end
  
  
  
  # def not_friends_with?(friend_id)
  #   friendships.where(friend_id: friend_id).count < 1
  # end
  
  # def except_current_user(users)
  #   users.reject { |user| user.id == self.id }
  # end
  
  # def self.search(param)
  #   return User.none if param.blank?
    
  #   param.strip!
  #   param.downcase!
  #   (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
  # end
  
  # def self.first_name_matches(param)
  #   matches('first_name', param)
  # end
  
  # def self.last_name_matches(param)
  #   matches('last_name', param)
  # end
  
  # def self.email_matches(param)
  #   matches('email', param)
  # end
  
  # def self.matches(field_name, param)
  #   where("lower(#{field_name}) like ?", "%#{param}%")
  # end
end
  


