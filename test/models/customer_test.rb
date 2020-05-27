require "test_helper"

describe Customer do
  let(:new_video) {
    new_video = Video.new(
    title: "Space Jam",
    overview: "basketball movie",
    release_date: Time.new(2018, 1, 1),
    inventory: 10,
    )
  }

  describe "instantiation" do
    it "can instantiate a customer" do
      customer = Customer.new(name: 'Jane Doe', address: 'Ap #292-5216 Ipsu Rd.', city: 'Hillsboro', state: 'OR', postal_code: '24301', phone: '(322) 510-8691')
      expect(customer.save)must_equal true
    end
  end

  describe "relationship" do
    it "can have multiple rentals"
    new_video.save!
    video = Video.last
    customer = customers(:customer1)
    rental_1 = Rental.new(video: video, checkout: Time.new(2020, 1, 1), due_date: Time.new(2020, 1, 7))
    rental_2 = Rental.new(video: video, checkout: Time.new(2020, 1, 1), due_date: Time.new(2020, 1, 7))

    customer.rentals << rental_1
    customer.rentals << rental_2

    expect(customer.rental.count).must_be :>, 1
    customer.rentals.each do |rental|
      expect(rental).must_be_instance_of Rental
    end
  end

  describe "validation" do
    it "must have a name" do
      customer = customers(:customer1)
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :name
      expect(customer.errors.messages[:name]).must_include "can't be blank"
    end
    it "must have a postal code" do
      customer = customers(:customer1)
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :postal_code
      expect(customer.errors.messages[:postal_code]).must_include "can't be blank"
    end
  end
end
