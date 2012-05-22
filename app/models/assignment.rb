class Assignment < ActiveRecord::Base
  attr_accessible :user_id, :role_id

  belongs_to :user
  belongs_to :role


  def Assignment.create_role_assignment_if_not_exists( role,  user )
    assignments_count = Assignment.find(:all, :conditions => {
      :role_id => role.id,
      :user_id =>user.id
    }).count
    
    if assignments_count == 0 
      Assignment.create(:user_id => user.id , :role_id => role.id)
    end
  end
  
    
end
