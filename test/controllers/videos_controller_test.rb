require "test_helper"

describe VideosController do
  it "must get index" do
  get videos_path
  must_respond_with :success
  expect(response.header["Content-Type"]).must_include "json"
  end

end
