require "test_helper"

describe Rental do


let(:rental1) {
  Rental.create(
    video_id: videos(:video1).id,
    customer_id: customers(:customer1).id,
    due_date: Date.today + 3,
    checkout_date: Date.today - 3
  )
}

  describe "validations" do
    it 'is valid when all fields are present' do
      # Act
      result = rental1.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a customer' do
      # Arrange
      rental1.customer_id = nil
    
      # Act
      result = rental1.valid?
    
      # Assert
      expect(result).must_equal false
    end

    it 'is invalid without a video' do
      # Arrange
      rental1.video_id = nil
    
      # Act
      result = rental1.valid?
    
      # Assert
      expect(result).must_equal false
    end

    it 'is invalid without a due date' do
      # Arrange
      rental1.due_date = nil
    
      # Act
      result = rental1.valid?
    
      # Assert
      expect(result).must_equal false
    end

    it 'is invalid without a checkout date' do
      # Arrange
      rental1.checkout_date = nil
    
      # Act
      result = rental1.valid?
    
      # Assert
      expect(result).must_equal false
    end
  end
end
