
 
object @retailer => :store
  attribute :name, :address, :city, :state, :zip, :contact_name, :contact_email
  attribute :created_at => :created
  attribute :updated_at => :updated
  child :deals do
    attributes :name, :description
    child :redemptions do
      attribute :customer_name, :sale_amount
      attribute :deal_discount_amount => :discount 
    end
  end


# attribute :favorite_coffee => :favoriteCoffee
#  
# if (Date.today.day % 7 == 0)
#   attributes :grouchy
# end
#  
# child :laptops do
#   attributes :name
# end
# 
# glue @patron do
#   attribute :zapme
#   attribute :another_test
# end
# 
# code :zapme do
#   "cool...eh"
# end
# 
# code :another_test do
#   { :sweetness => partial("/patrons/sample_partial", :object => @patron.laptops) }
# end 

=begin

You have to restart the server when you first install rabl and try to use it
Deep Nesting

In APIs, you can often need to construct 2nd or 3rd level nodes. Let's suppose we have a 'quiz' model that has many 'questions' and 
then each question has many 'answers'. We can display this hierarchy in RABL quite easily:

# app/views/quizzes/show.json.rabl
object @quiz
attribute :title
child :questions do
  attribute :caption
  child :answers do
    # Use inheritance to reduce duplication
    extends "answers/item"
  end
end
=end
