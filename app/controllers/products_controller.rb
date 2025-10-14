require "net/http"
require "json"

class ProductsController < ApplicationController
  BASE_URL = "https://fakestoreapi.com/products"

  def index
    @products = fetch_products
  rescue StandardError => e
    Rails.logger.error("Failed to load products: #{e.message}")
    @error = "Failed to fetch products: #{e.message}"
    @products = []
  end

  def show
    @product = fetch_product(params[:id])
  rescue StandardError => e
    Rails.logger.error("Failed to load product ##{params[:id]}: #{e.message}")
    @error = "Failed to fetch product details: #{e.message}"
    @product = nil
  end

  private

  def fetch_products
    fetch_json(URI(BASE_URL))
  end

  def fetch_product(id)
    raise ArgumentError, "Product ID is required" if id.blank?

    fetch_json(URI("#{BASE_URL}/#{id}"))
  end

  def fetch_json(uri)
    response = Net::HTTP.get_response(uri)
    unless response.is_a?(Net::HTTPSuccess)
      raise StandardError, "API responded with status #{response.code}"
    end

    JSON.parse(response.body)
  end
end
