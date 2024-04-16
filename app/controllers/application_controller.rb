class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_cart_item

  def current_cart_item
    if current_customer
      current_cart_item = current_customer.cart_item || current_customer.create_cart_item!
    else
      current_cart_item = CartItem.find_by(id: session[:cart_item_id]) || CartItem.create
      session[cart_item_id] ||= current_cart_item.id
    end
    current_cart_item
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      root_path
    else
      root_path
    end
  end

end
