require "test_helper"

describe Video do

  let(:movie) {videos(:toystory)}
  
  describe "validations" do
    it "is valid when all required fields are present" do
      expect(movie.valid?).must_equal true
    end

    it "is invalid when one of the required fileds is missing" do
      required_fields= ["title", "available_inventory", "release_date", "overview", "total_inventory"]
      
      required_fields.each do |field|
        movie[field] = nil
        expect(movie.valid?).must_equal false

        movie.reload
      end
    end

    it "is invalid when either total_inventory or available_inventory is not an integer" do
      inventory_fields = ["available_inventory", "total_inventory"]

      inventory_fields.each do |field|
        movie[field] = 0.5
        expect(movie.valid?).must_equal false

        movie[field] = "number_as_string"
        expect(movie.valid?).must_equal false

        movie.reload
      end
    end
  end

  describe "relations" do
    before do
      @titanic = Video.new(
        {
          title: "Titanic",
          overview: "You jump I jump!",
          release_date: "1997-12-19",
          total_inventory: 5,
          available_inventory: 5,
        }
      )
      @customer01 = customers(:jessica)
      @customer02 = customers(:cathy)
    end

    it "can have many rental records" do
      @titanic.save!
      rental01 = Rental.create!(video_id: @titanic.id, customer_id: @customer01.id)
      expect(@titanic.rentals.count).must_equal 1

      expect {
        Rental.create!(video_id: @titanic.id, customer_id: @customer02.id)
      }.must_differ "@titanic.rentals.count", 1

      @titanic.rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end
    end

    it "can have many customers through rentals" do
      Rental.create!(video_id: movie.id, customer_id: @customer01.id)
      Rental.create!(video_id: movie.id, customer_id: @customer02.id)

      movie.rentals.each do |rental|
        rental_customer = Customer.find_by(id: rental.customer_id)
        expect(rental_customer).must_be_instance_of Customer
      end
    end
  end
end
