require "test_helper"

describe VideosController do
  it "must get index for videos" do 
    get videos_path

    must_respond_with :ok
    expect(response.header['Content-Type']).must_include 'json' 
  end
end
