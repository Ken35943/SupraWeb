require "net/http"
require "json"

class ProductsController < ApplicationController
  BASE_URL = "https://fakestoreapi.com/products"

  def index
    @products = fetch_products
    @featured_product = @products.sample
    available_for_recommendations = @featured_product.present? ? @products.reject { |product| product["id"] == @featured_product["id"] } : @products
    sample_size = [available_for_recommendations.size, 8].min
    @recommended_products = available_for_recommendations.sample(sample_size)
    flash_sale_pool = available_for_recommendations.presence || @products
    flash_sale_count = [flash_sale_pool.size, 3].min
    @flash_sale_products = flash_sale_count.zero? ? [] : flash_sale_pool.sample(flash_sale_count)
    @flash_sale_deadline = @flash_sale_products.present? ? 45.minutes.from_now.iso8601 : nil
    @trending_categories = @products.group_by { |product| product["category"] }
                               .map { |category, items| { name: category, count: items.count } }
                               .sort_by { |category| -category[:count] }
                               .first(4)
  rescue StandardError => e
    Rails.logger.error("Failed to load products: #{e.message}")
    @error = "Failed to fetch products: #{e.message}"
    @products = []
    @featured_product = nil
    @recommended_products = []
    @flash_sale_products = []
    @flash_sale_deadline = nil
    @trending_categories = []
  end

  def show
    @product = fetch_product(params[:id])
    @recommended_products = fetch_products.reject { |item| item["id"].to_s == params[:id].to_s }
                                         .first(4)
  rescue StandardError => e
    Rails.logger.error("Failed to load product ##{params[:id]}: #{e.message}")
    @error = "Failed to fetch product details: #{e.message}"
    @product = nil
    @recommended_products = []
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
