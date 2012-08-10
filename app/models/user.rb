class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :goals


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :image
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           image:auth.info.image
                           )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def charge_card(amount, stripe_customer_id, goal)
    charge = Stripe::Charge.create(
    :amount => amount, # in cents
    :currency => "usd",
    :customer => stripe_customer_id
    )

    Charge.create(:amount => amount, :goal_id => goal.id, :stripe_charge_id => charge.id, :transaction_type => "initial charge")



  end

  def refund_money(amount, stripe_charge_id, goal)
    charge = Stripe::Charge.retrieve(stripe_charge_id)
    charge.refund(:amount => amount)


    Charge.create(:amount => amount, :goal_id => goal.id, :stripe_charge_id => charge.id, :transaction_type => "refund")

  end


end
