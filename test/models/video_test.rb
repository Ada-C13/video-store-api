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
  end

  # describe 'relationships' do
  #   before do
  #     @work_votes = @work.votes
  #     @work_users = @work.users
  #   end
  #   it 'relates to votes' do
      
  #     expect(@work_votes.count).must_equal 0
  #     vote = Vote.create(work_id: @work.id, user_id: users(:user1).id)
  #     expect(@work.votes.count).must_equal 1
  #   end

  #   it 'relates to users' do

  #     expect(@work_users.count).must_equal 0

  #     vote = Vote.create(work_id: @work.id, user_id: users(:user1).id)
  #     expect(@work.users.count).must_equal 1
  #   end

  # end

  # describe 'spotlight' do
  #   before do
  #     @vote1 = Vote.create(work_id: @work.id, user_id: users(:user1).id)
  #     @vote2 = Vote.create(work_id: @work.id, user_id: users(:user2).id)
  #     @work2 = works(:book2)
  #     @vote3 = Vote.create(work_id: @work2.id, user_id: users(:user1).id)
  #   end

  #   it 'can choose the work with the most votes to spotlight' do
  #     spotlight = Work.spotlight
  #     expect(spotlight).must_equal @work
  #     expect(spotlight.votes.count).must_equal 2
      
  #     @vote4 = Vote.create(work_id: @work2.id, user_id: users(:user2).id)
  #     @vote3 = Vote.create(work_id: @work2.id, user_id: users(:user3).id)
  #     spotlight2 = Work.spotlight
  #     expect(spotlight2).must_equal @work2
  #     expect(spotlight2.votes.count).must_equal 3
     
  #   end
  # end

  # describe 'top-10' do
  #   before do
  #     @work2 = works(:book2)
  #     @work3 = works(:movie2)
  #     @work4 = works(:album3)
  #     @vote1 = Vote.create(work_id: @work.id, user_id: users(:user1).id)
  #     @vote2 = Vote.create(work_id: @work.id, user_id: users(:user2).id)
  #     @vote3 = Vote.create(work_id: @work2.id, user_id: users(:user1).id)
  #     @vote4 = Vote.create(work_id: @work2.id, user_id: users(:user1).id)
  #     @vote5 = Vote.create(work_id: @work2.id, user_id: users(:user2).id)
  #     @vote6 = Vote.create(work_id: @work3.id, user_id: users(:user1).id)
  #     @vote6 = Vote.create(work_id: @work4.id, user_id: users(:user1).id)
  #   end

  #   it 'will select 10 works if works > 10 and all works if works < 10' do
  #     book_top10 = Work.top_ten(category: 'book')
  #     expect(Work.where(category: 'book').count).must_equal 12
  #     expect(book_top10.count).must_equal 10

  #     movie_top10 = Work.top_ten(category: 'movie')
  #     expect(Work.where(category: 'movie').count).must_equal 2
  #     expect(movie_top10.count).must_equal 2

  #     album_top10 = Work.top_ten(category: 'album')
  #     expect(Work.where(category: 'album').count).must_equal 3
  #     expect(album_top10.count).must_equal 3
  #   end

  #   it 'can order the top 10 categories from most to least votes' do
  #     book_top10 = Work.top_ten(category: 'book')
  #     movie_top10 = Work.top_ten(category: 'movie')
  #     album_top10 = Work.top_ten(category: 'album')

  #     expect(album_top10[0]).must_equal @work4
  #     expect(book_top10[0]).must_equal @work2
  #     expect(book_top10[1]).must_equal @work
  #     expect(movie_top10[0]).must_equal @work3
      
  #   end
  # end
end


