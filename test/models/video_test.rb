require "test_helper"

describe Video do

  before do
    @video = videos(:video1)
    @invalid_work = Video.new(total_inventory: 5)
  end

  describe 'validations' do

    it 'is valid when title, total inventory, and release date are present' do
      result = @video.valid?
      expect(result).must_equal true
    end

    it 'is invalid when title,total inventory, and/or release date  is not present' do
      result = @invalid_work.valid?
      @video.title = nil
      expect(result).must_equal false
      expect(@video.valid?).must_equal false
    end

    it 'will not allow you to create a video with the same title and release date as an exisiting video' do
      params = {
        title: 'Blacksmith Of The Banished', 
        release_date: '1979-01-18'
      }

      expect(Video.new(params).valid?).must_equal false
    end
    
    it 'validates if available_inventory  are integers' do
      expect(@video.valid?).must_equal true
      expect(@invalid_work.valid?).must_equal false
     

      @video.available_inventory = 1.2
      @video.save
      expect(@video.valid?).must_equal false

      @video.available_inventory = videos(:video1).available_inventory 
      @video.available_inventory = 3.5
      @video.save
      expect(@video.valid?).must_equal false

      
    end

    it 'validates if available_inventory and videos_checked_out_count are >= 0' do
      expect(@video.valid?).must_equal true
      expect(@invalid_work.valid?).must_equal false
    

      @video.available_inventory = -1
      @video.save
      expect(@video.valid?).must_equal false
      
      @video.available_inventory = videos(:video1).available_inventory 
      @video.save
      expect(@video.valid?).must_equal false
      
    end
  end
  describe "Video custom method" do
     describe "Increase Inventory" do
        it "will increase the video inventory" do
          video_inventory = @video.available_inventory
          @video.increase_available_inventory
          expect(@video.available_inventory).must_equal video_inventory + 1
        end
      end 

    describe "Decrease Inventory" do
      it "will decrease the video inventory" do
        video_inventory = @video.available_inventory
        @video.decrease_available_inventory
        expect(@video.available_inventory).must_equal video_inventory - 1
      end
    end
  end
  

  

end


