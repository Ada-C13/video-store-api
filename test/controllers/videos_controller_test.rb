require "test_helper"

describe VideosController do
  it "responds with JSON and success" do
    get videos_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :ok
  end

  it "must get index" do
    get videos_path
    must_respond_with :success
  end

  it "responds with an array of video hashes" do
    # Act
    get videos_path

    # Get the body of the response
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array
    body.each do |video|
      expect(video).must_be_instance_of Hash

      required_video_attrs = ["available_inventory", "id", "release_date", "title"]

      expect(video.keys.sort).must_equal required_video_attrs.sort
    end
  end

  it "will respond with an empty array when there are no videos" do
    # Arrange
    Video.destroy_all

    # Act
    get videos_path
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_instance_of Array
    expect(body).must_equal []
  end

  describe "show" do 
    it "must get show for valid ids" do
      video = videos(:valid_video)
      get video_path(video)
      must_respond_with :success

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
    end

    it "must respond with not found for invalid id" do
      # Act
      get video_path(-1)
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Hash
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    before do
      @video_hash = {
        
          title: "The Actors Are Chipmunks",
          overview: "A tale of anthropomorphization",
          release_date: "5/17/20",
          total_inventory: 5,
          available_inventory: 5
        
      }
    end
    
    it "can create a new video" do   
         
      expect {
          post videos_path, params: @video_hash
      }.must_differ "Video.count", 1

      new_video = Video.find_by(title: @video_hash[:title])
      expect(new_video.overview).must_equal @video_hash[:overview]
    end

    it "can will not create a new video if title isn't included" do      
      @video_hash[:title] = nil

        expect {
          post videos_path, params: @video_hash
      }.wont_change "Video.count"

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
    end

    it "can will not create a new video if available inventory isn't included" do      
      @video_hash[:available_inventory] = nil

        expect {
          post videos_path, params: @video_hash
      }.wont_change "Video.count"

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
    end
  end

end
