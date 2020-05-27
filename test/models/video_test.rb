require "test_helper"

describe Video do
  describe 'validations' do
    before do
      @video = videos(:brazil)
    end
    
    it 'is invalid without title' do
      @video.title = ''

      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :title
    end

    it 'is invalid without release date' do
      @video.release_date = ''

      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :release_date
    end

    it 'is invalid without total inventory' do
      @video.total_inventory = ''

      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :total_inventory
    end

    #TODO: Add validation for integer - also for positive integer
    # it 'is invalid if total inventory is not an integer' do
    #   @video.total_inventory = 'banana'

    #   expect(@video.valid?).must_equal false
    #   expect(@video.errors.messages).must_include :total_inventory
    # end

    it 'is invalid without available inventory' do
      @video.available_inventory = ''

      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :available_inventory
    end

    #TODO: Add validation for integer - also for positive integer
    # it 'is invalid if available inventory is not an integer' do
    #   @video.available_inventory = 'taco'

    #   expect(@video.valid?).must_equal false
    #   expect(@video.errors.messages).must_include :available_inventory
    # end

    it 'is invalid without overview' do
      @video.overview = ''

      expect(@video.valid?).must_equal false
      expect(@video.errors.messages).must_include :overview
    end

  end
end
