require "test_helper"

describe Video do
  describe 'validations' do
    before do
      @video = videos(:video1)
    end

    it 'is valid when all fields are present' do
      result = @video.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      @video.title = nil
      result = @video.valid?

      expect(result).must_equal false
      expect(@video.errors.messages).must_include :title
      expect(@video.errors.messages[:title]).must_include "can't be blank"
    end

    it 'is invalid without a overview' do
      @video.overview = nil
      result = @video.valid?

      expect(result).must_equal false
      expect(@video.errors.messages).must_include :overview
      expect(@video.errors.messages[:overview]).must_include "can't be blank"
    end

    it 'is invalid without a release_date' do
      @video.release_date = nil
      result = @video.valid?

      expect(result).must_equal false
      expect(@video.errors.messages).must_include :release_date
      expect(@video.errors.messages[:release_date]).must_include "can't be blank"
    end

    it 'is invalid without a total_inventory' do
      @video.total_inventory = nil
      result = @video.valid?

      expect(result).must_equal false
      expect(@video.errors.messages).must_include :total_inventory
      expect(@video.errors.messages[:total_inventory]).must_include "can't be blank"
    end

    it 'is invalid without a available_inventory' do
      @video.available_inventory = nil
      result = @video.valid?

      expect(result).must_equal false
      expect(@video.errors.messages).must_include :available_inventory
      expect(@video.errors.messages[:available_inventory]).must_include "can't be blank"
    end
  end
end
