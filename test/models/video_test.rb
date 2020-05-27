require "test_helper"

describe Video do
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

    it 'testing total_inventory validations' do
      videos = Video.all
      video = videos.last
      
      puts "this is total inventory #{video.total_inventory}"
      expect(video.valid?).must_equal false
       
    end
  end 
end
