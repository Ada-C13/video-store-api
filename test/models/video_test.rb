require "test_helper"

describe Video do
  describe "validations" do
    let (:video) {
      Video.new(
        title: "Sherlock Holmes",
        overview: "British detective solves mysteries",
        release_date: Date.new(2016),
        total_inventory: 5,
        available_inventory: 4
      )
    }

    it "is valid for a video with all required fields" do
      expect(video.valid?).must_equal true
    end 

    it "has the required fields" do
      video.save
      new_video = Video.first
    
      [:title, :overview, :release_date, :total_inventory, :available_inventory].each do |field|
        expect(new_video).must_respond_to field
      end
    end

    it "is invalid without a title" do
      video.title = nil
      
      expect(video.valid?).must_equal false
      expect(video.errors.messages).must_include :title
    end

    it "is invalid without a overview" do
      video.overview = nil
      
      expect(video.valid?).must_equal false
      expect(video.errors.messages).must_include :overview
    end
    
    it 'is invalid without a release_date' do
      video.release_date = nil
      
      expect(video.valid?).must_equal false
      expect(video.errors.messages).must_include :release_date
    end
    
    it 'is invalid without total_inventory' do
      video.total_inventory = nil
      
      expect(video.valid?).must_equal false
      expect(video.errors.messages).must_include :total_inventory
    end
    
    
    it 'is invalid when available_inventory' do
      video.available_inventory = nil
      
      expect(video.valid?).must_equal false
      expect(video.errors.messages).must_include :available_inventory
    end
  end
end
