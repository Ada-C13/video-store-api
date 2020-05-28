require "test_helper"

describe Rental do
  describe 'validations' do
    it "can be created with a valid customer id and valid video id" do
      # Arrange 
      shelley = customers(:shelley)
      joker = videos(:joker)
      rental = Rental.create(customer_id: shelley.id, video_id: joker.id)

      # Act
      result = rental.valid?

      # Assert 
      expect(result).must_equal true
    end 

    it "cannot be created with an invalid customer id" do
      # Arrange 
      joker = videos(:joker)
      rental = Rental.create(customer_id: -1, video_id: joker.id)

      # Act
      result = rental.valid?

      # Assert 
      expect(result).must_equal false
    end

    it "cannot be created with an invalid video id" do
      # Arrange 
      shelley = customers(:shelley)
      rental = Rental.create(customer_id: shelley.id, video_id: -1)

      # Act
      result = rental.valid?

      # Assert 
      expect(result).must_equal false
    end
  end
end
