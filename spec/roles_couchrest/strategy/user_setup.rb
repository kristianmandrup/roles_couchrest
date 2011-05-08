def default_user_setup         
  puts "Roles created: #{Role.all}"  
  
  @guest_user = User.create(:name => 'Guest user')
  @guest_user.add_roles :guest
  @guest_user.save
  
  # @normal_user = User.create(:name => 'Normal user')
  # @normal_user.roles = :guest, :user
  # @normal_user.save     
  # 
  # @admin_user = User.create(:name => 'Admin user')
  # @admin_user.add_roles :admin
  # @admin_user.save
  
  puts "Guest: #{@guest_user.inspect}, Admin: #{@admin_user.inspect}"
end
