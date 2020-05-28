require "test_helper"

describe Video do
  let (:new_video) {
    Video.new(
      title: 'Harry Potter 3',
      overview: 'The best movie ever!',
      release_date: '2009-12-25',
      total_inventory: 10,
      available_inventory: 10
    )
  } 

  describe 'instantize' do
    it 'can be instantiated' do
      expect(new_video.valid?).must_equal true
    end

    it 'will have the required field' do
      new_video.save
      video = Video.first
      [:title, :overview, :release_date , :total_inventory ,:available_inventory].each do |field|
        expect(video).must_respond_to field
      end
    end
  end

    describe 'relationship' do
      it 'can have many rentals' do
        video = videos(:lalaland)

        video.rentals.each do |rental|
          expect(rental).must_be_instance_of Rental
        end

        expect(video.rentals.count).must_equal 2
      end   
    end

    describe 'validations' do
      it 'is valid when all the required fields are provided' do
        new_video = Video.new( 
          title: 'Passenger',
          overview: 'Heartwarming movie!',
          release_date: '2018-12-25',
          total_inventory: 15,
          available_inventory: 10)

        expect(new_video.valid?).must_equal true
      end
      
      it 'fails validation when there is one or more required field is missing' do
        new_video.title = nil
        new_video.overview = nil

        expect(new_video.valid?).must_equal false
        expect(new_video.errors.messages).must_include :title
        expect(new_video.errors.messages).must_include :overview
      end
    end
  
end
