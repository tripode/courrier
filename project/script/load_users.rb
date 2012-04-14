User.transaction do

    User.create(:username     => 'admin',
                :email        => 'admin@admin.com',
                :password     => 'pass',
                :employee_id  => Employee.first.id,
                :role_ids     => Role.where(:name => 'Administrator').first.id
               )
end