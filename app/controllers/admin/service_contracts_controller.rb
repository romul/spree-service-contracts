class Admin::ServiceContractsController < Admin::BaseController    
  resource_controller
  helper :products
  before_filter :find_product
    
  create.success.wants.html { redirect_to collection_url }
  update.success.wants.html { redirect_to collection_url }
  destroy.success.wants.js { render_js_for_destroy }
  
  def index
    @service_contracts = @product ? @product.service_contracts : ServiceContract.all
    render @product ? "product_index" : "index"
  end

  def available
    if params[:q].blank?
      @available_contracts= []
    else
      @available_contracts = ServiceContract.name_like(params[:q]) - @product.service_contracts
    end
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end    
  end
  
  def select
    @contract = ServiceContract.find(params[:id])
    @product.service_contracts << @contract
		render :update do |page|
			page.replace_html :product_service_contracts, :partial => "service_contracts_table", 
			                  :locals => {:service_contracts => @product.service_contracts}
	  end     
  end
  
  def remove
    @contract = ServiceContract.find(params[:id])
    @product.service_contracts.delete(@contract)
		render :update do |page|
			page.replace_html :product_service_contracts, :partial => "service_contracts_table", 
			                  :locals => {:service_contracts => @product.service_contracts}
	  end    
  end

  private
    def find_product
      if params[:product_id]
        @product = Product.find_by_permalink(params[:product_id])
        @product_admin_tabs << { :name => "Contracts", :url => "admin_product_service_contracts_url" }
      end
    end 
end
