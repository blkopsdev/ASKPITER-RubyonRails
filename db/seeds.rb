# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

user = User.create(name: "John", email: "john.smith@yahoo.com", password: "12345678", password_confirmation: "12345678", last_name: "Smith", dob: Date.today, sex: 1, company: true)

father_category = FatherCategory.create(name: "Default father category")

category = Category.create(name: "Default category", father_category: father_category)
user.favourite_categories << category

video = Video.create(title: "New video", url: "http://yahoo.com", main: false, comment: "New comment for video", day: false, caption: "New caption")
user.videos << video

address = Address.create(street: "Default address", postcode: "000000", city: "Vologda", country: "Australia", latitude: 43.0, longitude: 131)

company = Company.create(name: "Name for company", url: "http://yahoo.com", description: "Description for company", email: "c@yahoo.com", phone: "+7000000", fax: "fax")
company.address = address

user.favourite_companies << company

picture = Picture.create(title: "Default title for picture")

language = Language.create(name: "EN")

currency = Currency.create(name: "Dollar", exchange_rate: 0.1, sign: "$", code: "USD")

sub_category = SubCategory.create(name: "Sub-category", category: category)

product = Product.create(name: "Product name", description: "Description for product", year: 2016, url: "http://product.url")

company.products << product
product.sub_category = sub_category

attribute = Attribute.create(title: "Title for attr", value: "111")
product.attrs << attribute

rating = Rating.create(value: 4)

review = Review.create(title: "Review title", review: "Review text")

video = Video.create(title: "Video.title", url: "video@yahoo.com", main: true, comment: "Comment", day: true, caption: "caption")
photo = Photo.create(main: true, comment: "Comment text", day: true)
distributor = Distributor.create(information: "Information", phone: "+7000000", url: "ahoo.com", email: "d@yahoo.com")
search = Search.create(text: "search text fff")
dimension = Dimension.create(text: "300x400")

pos = POS.create(company: company, distributor: distributor)
price = Price.create(amount: 34.0)
user.update_attributes(address: address, picture: picture, language: language, currency: currency, ratings: [rating], photos: [photo], searches: [search], favourite_companies: [company], favourite_products: [product], videos: [video])
language.update_attributes(reviews: [review])
currency.update_attributes(prices: [price])
category.update_attributes(videos: [video], photos: [photo])
product.update_attributes(sub_category: sub_category, ratings: [rating], videos: [video], dimensions: [dimension], photos: [photo], pictures: [picture], prices: [price])
distributor.update_attributes(address: address)
user.save

