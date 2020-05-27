require "test_helper"

describe Customer do

  before do
    @customer = customers(:customer1)
    @invalid_work = Customer.new(postal_code: '98102')
  end

  # describe 'validations' do

  #   it 'is valid when all required params are present' do
  #     result = @customer.valid?
  #     expect(result).must_equal true
  #   end

  #   it 'is invalid when required params are not present' do
  #     result = @invalid_work.valid?
  #     @customer.title = nil
  #     expect(result).must_equal false
  #     expect(@customer.valid?).must_equal false
  #   end

  #   it 'will not allow you to create a work in the same category with the same title' do
  #     expect(Customer.create(title:'Winnie the Pooh').valid?).must_equal false
  #   end
  # end

  describe 'relationships' do
    before do
      @work_votes = @work.votes
      @work_users = @work.users
    end
    it 'relates to votes' do
      
      expect(@work_votes.count).must_equal 0
      vote = Vote.create(work_id: @work.id, user_id: users(:user1).id)
      expect(@work.votes.count).must_equal 1
    end

    it 'relates to users' do

      expect(@work_users.count).must_equal 0

      vote = Vote.create(work_id: @work.id, user_id: users(:user1).id)
      expect(@work.users.count).must_equal 1
    end

  end

end
