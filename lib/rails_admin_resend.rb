require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminResend

end

module RailsAdmin
  module Config
    module Actions
      class Resend < Base

        register_instance_option :member? do
          true
        end

        register_instance_option :link_icon do
          'icon-envelope'
        end
        
        register_instance_option :controller do
          Proc.new do
            if @object.order.is_trade_ins?
              OrderNotifier.confirm_to_sell(@object.order, @object).deliver
            else
              OrderNotifier.confirm_to_buy(@object.order, @object).deliver
            end
            flash[:notice] = "The Stamp has been re-printed and sent to client."
            redirect_to back_or_index
          end
        end
      end
    end
  end
end