require "test_helper"

describe Video do
  let(:video) {videos(:video3)}
  let(:customer) { customers(:customer) }
  let(:customer2) { customers(:customer1) }

  describe "relations" do
    it "can have many rentals" do
      Rental.create(video_id: video.id, customer_id: customer.id, due_date: Date.today)
      Rental.create(video_id: video.id, customer_id: customer2.id, due_date: Date.today)
      expect(video.rentals.length).must_equal 2  
    end
  end
  
  describe 'validations' do

    it 'can be instantiated when all fields are present' do
      videos = Video.all
      video = videos.first
       
        expect(video["id"]).wont_be_nil
        expect(video["title"]).wont_be_nil
        expect(video["overview"]).wont_be_nil
        expect(video["release_date"]).wont_be_nil
        expect(video["total_inventory"]).wont_be_nil
        expect(video["available_inventory"]).wont_be_nil
    end

    # it 'testing total_inventory validations' do
      
    #   puts "this is total inventory #{video.total_inventory}"
    #   expect(video.valid?).must_equal false
    
       
    # end

    it "is not valid when title is missing" do
      video.title = nil
      
      expect(video.valid?).must_equal false
    end
    
    it "is not valid when overview is missing" do
      video.overview = nil
      
      expect(video.valid?).must_equal false
    end
    
    it "is not valid when release_date is missing" do
      video.release_date = nil
      
      expect(video.valid?).must_equal false
    end
    
    it "is not valid when total_inventory is missing" do
      video.total_inventory = nil
      
      expect(video.valid?).must_equal false
    end
    
    it "is not valid when total_inventory is not an integer" do
      video.total_inventory = "five"
      
      expect(video.valid?).must_equal false
    end

    #chelsea added
    it "is not valid when available_inventory is not an integer" do
      video.available_inventory = "five"
      
      expect(video.valid?).must_equal false
    end

    it "is not valid when available_inventory is missing" do
      video.available_inventory = nil
      
      expect(video.valid?).must_equal false
    end
  end 
end


  
  
   
    
  