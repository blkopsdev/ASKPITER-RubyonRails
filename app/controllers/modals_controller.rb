class ModalsController < ApplicationController
  include ImitateDelay
  include HelperAttr

  helper_attr :body_locals

  before_action { request.format = :json }
  before_action { self.body_locals ||= {} }
  before_action :set_addendum_locals, only: %i(add_photo add_video add_picture)

  imitate_delay
  layout false

  def fetch
    if params[:category_id].present?
      category = Category.find_by(id: params[:category_id])
      render json: {
        company: ActiveModel::ArraySerializer.new(category.companies.uniq, each_serializer: CompanySerializer),
        product: ActiveModel::ArraySerializer.new(category.products, each_serializer: ProductSerializer)
      }
    elsif params[:company_id].present?
      company = Company.find_by(id: params[:company_id])
      render json: { product: ActiveModel::ArraySerializer.new(company.products, each_serializer: ProductSerializer) }
    else
      render jso: {}
    end
  end

  private

  def set_addendum_locals
    @categories = Category.includes(:products).all
    @companies = Company.includes(:products).all
    @products = []
  end
end
