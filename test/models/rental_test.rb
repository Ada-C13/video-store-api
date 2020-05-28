require "test_helper"

describe Rental do
  let(:new_customer) {
    Customer.new( 
      name: 'Hannah Joo',
      registered_at: 'Wed, 27 May 2020 11:54:14 -0700',
      address: '1234 Main Street',
      city: 'Seattle',
      state: 'WA',
      postal_code: '90818',
      phone: '(333) 510-8695',
      videos_checked_out_count: 0,
    )
  }
  let(:new_video) {
    Video.new(
    title: 'Hello Kitty Adventure',
    overview: 'Great Movie for Hello Kitty fan',
    release_date: '2008-11-28',
    total_inventory: 20,
    available_inventory: 20,
    )
  }
  let(:new_rental) {
    Rental.new(
      customer: new_customer,
      video: new_video,
      due_date: 'Wed, 03 Jun 2020'
    )
  }
  describe 'instantize and validations' do
    it 'can be instantiated' do
      expect(new_rental.valid?).must_equal true
    end

    it 'cannot be instantiated with invalid customer id' do
      new_rental =  Rental.new(customer_id: -1 , video: videos(:sing), due_date: 'Wed, 03 Jun 2020')
      expect(new_rental.valid?).must_equal false
    end

    it 'cannot be instantiated with invalid video id' do
      new_rental =  Rental.new(customer: customers(:ross) , video_id: -1, due_date: 'Wed, 03 Jun 2020')
      expect(new_rental.valid?).must_equal false
    end

    it 'cannot be instantiated without a due date' do
      new_rental =  Rental.new(customer: customers(:ross) , video: videos(:sing), due_date: nil)
      expect(new_rental.valid?).must_equal false
    end


    it 'will have the required field' do
      new_rental.save
      rental = Rental.last

      [:customer_id, :video_id, :due_date].each do |field|
        expect(rental).must_respond_to field
      end
    end
  end

  describe 'relationship' do
    it 'can belongs to a customer and a video' do
      rental = rentals(:one)
      
      expect(rental.customer).must_be_instance_of Customer
      expect(rental.video).must_be_instance_of Video
      expect(rental.customer.name).must_equal 'Sharon Cheung'
      expect(rental.video.title).must_equal  "La La Land"
    end
  end

  describe "increment_videos_checked_out_count & decrement_available_inventory" do 
    it "will increment customer checkout count by 1 and decrement vidoe avaliable inventory once a Rental is created" do
    # Act
    customer = customers(:shelley)
    video = videos(:frozen)
    rental = Rental.create!(customer_id: customer.id, video_id: video.id, due_date:'Wed, 03 Jun 2020')
    
    # Assert
    customer.reload
    video.reload
    expect(customer.videos_checked_out_count).must_equal 1
    expect(video.available_inventory).must_equal 19
    end
  end

  describe "decrement_videos_checked_out_count & increment_available_inventory" do 
    it "will decrease customer checkout count by 1 and increase vidoe avaliable inventory once a checkin action is called" do
    # Act
    customer = customers(:sharon)
    video = videos(:frozen)
    rental = Rental.create!(customer_id: customer.id, video_id: video.id, due_date:'Wed, 03 Jun 2020')
    
    # Assert
    customer.reload
    video.reload
    expect(customer.videos_checked_out_count).must_equal 2
    expect(video.available_inventory).must_equal 19
    
    rental.decrement_videos_checked_out_count
    rental.increment_available_inventory

    customer.reload
    video.reload
    expect(customer.videos_checked_out_count).must_equal 1
    expect(video.available_inventory).must_equal 20
    end
  end
end
