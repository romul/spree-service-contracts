# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ServiceContractsExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/service_contracts"
  
  def activate
    
    Product.class_eval do
      has_and_belongs_to_many :service_contracts
    end
    
    # Add a link to the shipment centers administration page on the configuration page
    Admin::ConfigurationsController.class_eval do
      before_filter :add_service_contract_links, :only => :index

      def add_service_contract_links
        @extension_links << {:link => admin_service_contracts_path, :link_text => t(:service_contracts), :description => t(:manage_service_contracts)}
      end
    end
    
    Admin::ProductsController.class_eval do
      before_filter :add_contracts_tab
      private
      def add_contracts_tab
        @product_admin_tabs << { :name => "Contracts", :url => "admin_product_service_contracts_url" }
      end
    end
    
  end
end
