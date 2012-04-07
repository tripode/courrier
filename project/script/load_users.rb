User.transaction do

    User.create(:email        => 'admin@admin.com',
                :password     => 'pass',
                :employee_id  => 1,
                :role_ids     => Role.where(:name => 'Administrator').first.id
               )
end