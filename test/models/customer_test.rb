require "test_helper"

describe Customer do

  before do
    @customer = customers(:customer1)
    @invalid_customer = Customer.new(postal_code: '98102')
  end

  describe 'validations' do

    it 'validates that videos_checked_out_count is an integer' do
      expect(@customer.valid?).must_equal true
      expect(@invalid_customer.valid?).must_equal false
      
      @customer.videos_checked_out_count = 7.5
      @customer.save
      expect(@customer.valid?).must_equal false
      
    end

    it 'validates that videos_checked_out_count is >= 0' do
      expect(@customer.valid?).must_equal true
      expect(@invalid_customer.valid?).must_equal false
      
      @customer.videos_checked_out_count = -6
      @customer.save
      expect(@customer.valid?).must_equal false
    end

  end
  describe "Customer custom method" do
    describe "Increase Customer Video Checkout Count" do
      it "will increase the customer checked out count" do
        customer_video_checked = @customer.videos_checked_out_count
        @customer.increase_checked_out
        expect(@customer.videos_checked_out_count).must_equal 2
      end
    end
    describe "Decrease Customer Video Checkout Count" do
      it "will decrease the video inventory" do
        customer_video_checked = @customer.videos_checked_out_count
        @customer.decrease_checked_out
        expect(@customer.videos_checked_out_count).must_equal 0
      end
    end
  end
  # describe 'relationships' do
  #   before do
  #     @work_votes = @work.votes
  #     @work_users = @work.users
  #   end
  #   it 'relates to votes' do
      
  #     expect(@work_votes.count).must_equal 0
  #     vote = Vote.create(work_id: @work.id, user_id: users(:user1).id)
  #     expect(@work.votes.count).must_equal 1
  #   end

  #   it 'relates to users' do

  #     expect(@work_users.count).must_equal 0

  #     vote = Vote.create(work_id: @work.id, user_id: users(:user1).id)
  #     expect(@work.users.count).must_equal 1
  #   end

  # end

end
