# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

administrator = User.new(username: "Administrator", password: "Administrator")
check = User.find_by(username: "Administrator")
if check == nil
    administrator.save
end

label = Label.new(label_name: "Technology")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Movies")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Games")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Travel")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Food")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Pets")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Finance")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Music")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Hobbies")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Lifestyle")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save
label = Label.new(label_name: "Work")
check = Label.find_by(label_name: label.label_name)
if check == nil
    label.save
end
label.save