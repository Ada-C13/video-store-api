require "test_helper"

describe Rental do
  it "will return true if valid customer and video" do
    customer = customers(:shelley)
    customer.save 
    video = videos(:vid1)
    video.save 
    date = DateTime.now + 1.week

    rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)

    answ = Rental.inventory_check_out(rental)

    expect(answ).must_equal true 
  end

  it "will return flase if for invalid customer" do
    video = videos(:vid1)
    video.save 
    date = DateTime.now + 1.week
    rental = Rental.new(due_date: date, customer_id: 1000, video_id: video.id)
    answ = Rental.inventory_check_out(rental)
    expect(answ).must_equal false 
  end

  it "will decrement video availibility and will increment customer videos" do 
    customer = customers(:shelley)
    customer.save 
    video = videos(:vid1)
    video.save 
    date = DateTime.now + 1.week

    rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)
    
    answ = Rental.inventory_check_out(rental)

    
    video.reload
    customer.reload
    expect(answ).must_equal true
    
    expect(video.available_inventory).must_equal 1
    expect(customer.videos_checked_out_count).must_equal 2

  end 


end
