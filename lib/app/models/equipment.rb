class Equipment< ActiveRecord::Base
 
 attr_accessible :comment, :mac, :model_id, :status, :supplier_id
 STATUS = %w[STOCK BAJA REPARACION]
 #before_update :update_if_change_status, only: [:edit, :update] 

  scope :with_parameters, ->(mac){
        where("mac LIKE ?", "#{mac}%".downcase)}
  scope :with_params_id, ->(id) {where("id = ?", "#{id}")}
  #Relaciones
      has_many :loan
      belongs_to :model
      belongs_to :supplier  
  
  #validations
    validates :mac, :uniqueness => true
    validates_presence_of :model, :supplier

 # def update_if_change_status
  #  if  self.status_changed?
   #   @equipment = Equipment.new(self.equipment)
    #  @equipment.save  
    #end
 # end


end
