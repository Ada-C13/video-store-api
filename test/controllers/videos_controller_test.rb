require "test_helper"
 REQUIRED_VIDEO_FIELDS = ["id","name", "species", "age","owner"].sort
describe VideosController do

  def check_response(expected_type: expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end
  describe "index" do 
    it "responds with JSON and success" do
      get videos_path

      body = check_response(expected_type: Array)

      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal REQUIRED_VIDEO_FIELDS
end
