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

    it "Can not chech_out rental if video dosnt exist" do
      rental_params[:video_id] = nil
      expect{ post check_out_path, params: rental_params}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end


  end





end
