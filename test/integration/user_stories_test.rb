require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest


  fixtures :products
  #replace this with your real tests
  test "buying a product" do
    LineItem.delete_all
    order.delete_all
    ruby_book = products(:ruby)

    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal tuby_book, cart.line_item[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
                      order: { name:     "Kasper Taber",
                               address:  "taber sted",
                               email:    "dave@example.com"
                               pay_type: "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    assert_equal "Kasper Taber",     order.name
    assert_equal "taber sted",       order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check",            order.pay_type
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "pragmatic Store ORder Confirmation", mail.subject
  end
end