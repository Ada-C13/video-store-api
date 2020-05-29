require "test_helper"

describe RentalsController do
  let(:new_video) {
    Video.create(
      title: "Star Wars",
      overview: "Family Space Odyssey",
      release_date: Date.today,
      total_inventory: 10,
      available_inventory: 5
    )
  }

  let(:customer1) { customers(:customer1) }

  let(:rental_data) {
    {
      customer_id: customer1.id, 
      video_id: new_video.id
    }
  }

  describe "checkout" do

    it "creates a rental" do
      expect { 
        post checkout_path, params: rental_data 
      }.must_differ "Rental.count", 1

      check_response(expected_type: Hash, expected_status: :ok)
    end

    it "fails if given an invalid customer id" do
      # Arrange - using let from above
      rental_data[:customer_id] = nil

      expect {
        # Act
        post checkout_path, params: rental_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "fails if given an invalid video id" do
      # Arrange - using let from above
      rental_data[:video_id] = nil

      expect {
        # Act
        post checkout_path, params: rental_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "has a checkout date" do
      post checkout_path, params: rental_data
      
      expect(Rental.last.checkout_date).must_equal Date.today
    end

    it "increases customer's videos_checked_out_count by 1" do
      expect(customer1.videos_checked_out_count).must_equal 0
      
      post checkout_path, params: rental_data
      customer1.reload
      
      expect(customer1.videos_checked_out_count).must_equal 1
    end

    it "decreases the video's available inventory by one" do
      expect(new_video.available_inventory).must_equal 5
      
      expect{
        post checkout_path, params: rental_data
        new_video.reload
      }.must_differ "new_video.available_inventory", -1

      expect(new_video.available_inventory).must_equal 4
    end

    it "adds a due date 7 days after the checkout" do
      post checkout_path, params: rental_data
      
      expect(Rental.last.due_date).must_equal Date.today + 7
    end

  end

  describe "checkin" do
    
    it "checkin a valid rental" do
      # Arrange
      post checkout_path, params: rental_data 
      new_rental = Rental.last

      # Act
      post checkin_path, params: rental_data
  
      # Assert
      check_response(expected_type: Hash, expected_status: :ok)
    end

    it "rejects an invalid rental - bad customer" do
      # Arrange
      rental_data[:customer_id] = -1

      # Act
      post checkin_path, params: rental_data
  
      # Assert
      check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "rejects an invalid rental - bad video" do
      # Arrange
      rental_data[:video_id] = -1
      
      # Act
      post checkin_path, params: rental_data
  
      # Assert
      check_response(expected_type: Hash, expected_status: :not_found)
    end

  end

end
