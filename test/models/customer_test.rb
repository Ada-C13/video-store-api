require "test_helper"

describe Customer do
  let (:new_customer) {
    Customer.new(
      name: "Jessica",
      address: "123 Street",
      city: "Seattle",
      state: "WA",
      postal_code: "12345",
      phone: "123-345-5678",
      registered_at: "2014-12-12T06:20:46.000Z",
      videos_checked_out_count: 1
    )
  }

  it "can be instantiated" do
    # Assert
    expect(new_customer.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_customer.save
    customer = Customer.first
    [:name, :address, :city, :state, :postal_code, :phone].each do |field|
      # Assert
      expect(customer).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many rentals" do
      # Arrange
      new_customer.save
      new_video = Video.create(
        title: "a video",
        overview: "a cool video", 
        total_inventory: "5", 
        available_inventory: "3", 
        release_date: "1999-12-01"
      )
      rental_1 = Rental.create(customer_id: new_customer.id, video_id: new_video.id)
      rental_2 = Rental.create(customer_id: new_customer.id, video_id: new_video.id)
      
      # Assert
      expect(new_customer.rentals.count).must_equal 2
      new_customer.rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      new_customer.name = nil

      # Assert
      expect(new_customer.valid?).must_equal false
      expect(new_customer.errors.messages).must_include :name
      expect(new_customer.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have an address" do
      # Arrange
      new_customer.address = nil

      # Assert
      expect(new_customer.valid?).must_equal false
      expect(new_customer.errors.messages).must_include :address
      expect(new_customer.errors.messages[:address]).must_equal ["can't be blank"]
    end

    it "must have a city" do
      # Arrange
      new_customer.city = nil

      # Assert
      expect(new_customer.valid?).must_equal false
      expect(new_customer.errors.messages).must_include :city
      expect(new_customer.errors.messages[:city]).must_equal ["can't be blank"]
    end

    it "must have a state" do
      # Arrange
      new_customer.state = nil

      # Assert
      expect(new_customer.valid?).must_equal false
      expect(new_customer.errors.messages).must_include :state
      expect(new_customer.errors.messages[:state]).must_equal ["can't be blank"]
    end

    it "must have a postal_code" do
      # Arrange
      new_customer.postal_code = nil

      # Assert
      expect(new_customer.valid?).must_equal false
      expect(new_customer.errors.messages).must_include :postal_code
      expect(new_customer.errors.messages[:postal_code]).must_equal ["can't be blank"]
    end

    it "must have a phone" do
      # Arrange
      new_customer.phone = nil

      # Assert
      expect(new_customer.valid?).must_equal false
      expect(new_customer.errors.messages).must_include :phone
      expect(new_customer.errors.messages[:phone]).must_equal ["can't be blank"]
    end
  end

  describe "increase_videos_checked_out_count" do
    it "increases the videos checked out count by 1" do
      # Arrange
      new_customer.save!

      # Assert
      expect {
        new_customer.increase_videos_checked_out_count
      }.must_differ "new_customer.videos_checked_out_count", 1
    end
  end

  describe "decrease_videos_checked_out_count" do
    it "decreases the videos checked out count by 1" do
      # Arrange
      new_customer.save!

      # Assert
      expect {
        new_customer.decrease_videos_checked_out_count
      }.must_differ "new_customer.videos_checked_out_count", -1
    end
  end
end
