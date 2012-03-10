require 'date'
Employee.transaction do
    date= Time.now + 6.days
    (1..10).each do |t|
      Employee.create(
        :email=>"empleado_#{t}@server.com",
        :name=>"empleado_nombre_#{t}",
        :last_name =>"empleado_apellido_#{t}",
        :num_identity => "#{t*10000}",
        :address=>"calle cualquiera numero #{t}",
        :admission_date=>date,
        :birthday=>date,
        :salary=>1000000,
        :mobile_number=>"(09xx)00000#{t}",
        :phone_number=>"(071)00000#{t}",
        :function_type_id=>3
      )
    end
    Employee.create(
        :email=>"raulbeni@gmail.com",
        :name=>"Raul",
        :last_name =>"Benitez",
        :num_identity => "3206015",
        :address=>"Quiteria",
        :admission_date=>date,
        :birthday=>date,
        :salary=>1000000,
        :mobile_number=>"(09xx)00000#{t}",
        :phone_number=>"(071)00000#{t}",
        :function_type_id=>3
      )

end