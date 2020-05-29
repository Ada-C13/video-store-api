require "test_helper"

describe RentalsController do
  it "must get index" do
    get rentals_index_url
    must_respond_with :success
  end

  describe 'check_out' do
    before do 
      @customer = customers(:customer2)
      @video = videos(:video1)
    end
    let(:rental_params) {
      {
        customer_id: @customer.id,
        video_id: @video.id,
        due_date: Date.today
      }
    }

    it 'Can chech_out the rental' do
      expect{ post check_out_path, params: rental_params }.must_differ "Rental.count", 1
    
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash 
    end


  end





end
