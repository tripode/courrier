Role.transaction do

    Role.create(:name=> 'Administrator')
    Role.create(:name=> 'Deliver')
    Role.create(:name=> 'Secretary')

end