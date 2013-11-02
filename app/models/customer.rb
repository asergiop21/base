class Customer < ActiveRecord::Base
  CATEGORY= %w[HOGAR EMPRESA]
  INVOICE = %w[A B C]
  PHONES_COUNT_MIN = 0


scope :con_nombre, ->(nombre){where("LOWER(lastname) LIKE ?", "%#{nombre}%".downcase)}
scope :con_id, ->(id){ where('id = ?', "#{id}")}
scope :removed, ->(removed){ where('removed = ?', "#{removed}")}
  #Atributos
  attr_accessible :address, :bar_code, :date_of_birth, :category, :cuit, :description, :dni, :email, :lastname, :name, :neighborhood, :reference_direction, :removed, :phones_attributes, :location_id,  :user_id, :invoice, :payments_attributes

  #Relaciones
  has_many :phones, :dependent => :destroy
  has_many :loans
  has_many :ips
  has_many :invoices
  has_many :payments
  belongs_to :user
  belongs_to :location
  has_many :accounts_receivable

  #Validaciones
  validates :name, :lastname, :address, :date_of_birth, :dni, :category,  :location_id,   presence: true
  validates :name, uniqueness: {scope: :lastname}, allow_nil: true, allow_blank: true
  validates :name, :lastname, :address, :neighborhood, :reference_direction, :email, length: {maximum: 255}, allow_nil: true, allow_blank: true 
  validates :dni, length: {is: 8}, numericality: true
  validates :cuit, length: {is: 13}, allow_nil: true, allow_blank: true
  validates :email,   
            :uniqueness => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates_date :date_of_birth, :before => lambda { 18.years.ago }
  validates_presence_of  :phones
 
 
#accepts_nested_attributes_for :phones, :reject_if => lambda {|a| a[:phone_number].blank? }, allow_destroy: true

 accepts_nested_attributes_for :phones, reject_if: :reject_phones, :allow_destroy => true
 accepts_nested_attributes_for :payments


 def self.search (q=nil)
     self.connection.execute(sanitize_sql(["SELECT * FROM customers"]))
 end

 
 
 private
 def reject_phones(attribute)

       if phones.count > PHONES_COUNT_MIN 
            puts "hola" 
          attribute[:phone_number].blank?
      end
 end




end
