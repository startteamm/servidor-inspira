class Api::V1::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    include Devise::Controllers::Rememberable

    def redirect_callbacks
        devise_mapping = get_devise_mapping
        redirect_route = get_redirect_route(devise_mapping)
  
        session['dta.omniauth.auth'] = request.env['omniauth.auth'].except('extra')
        session['dta.omniauth.params'] = request.env['omniauth.params']
  
        redirect_to redirect_route
    end
  
    def get_redirect_route(devise_mapping)
        path = "#{Devise.mappings[devise_mapping.to_sym].fullpath}/#{params[:provider]}/callback"
        klass = request.scheme == 'https' ? URI::HTTPS : URI::HTTP
        redirect_route = klass.build(host: request.host, port: request.port, path: path).to_s
    end
  
    def get_devise_mapping
        # derive target redirect route from 'resource_class' param, which was set
        # before authentication.
        devise_mapping = [request.env['omniauth.params']['namespace_name'],
                        request.env['omniauth.params']['resource_class'].underscore.gsub('/', '_')].compact.join('_')
        rescue NoMethodError => err
        default_devise_mapping
    end

    def omniauth_success
      get_resource_from_auth_hash
      set_token_on_resource
      create_auth_params
  
      if resource_class.devise_modules.include?(:confirmable)
        @resource.skip_confirmation!
      end
  
      sign_in(:user, @resource, store: false, bypass: false)
  
      @resource.save!
  
      yield @resource if block_given?
      
      render(json: { auth_params: @auth_params, resource: @resource })
    end

    def omniauth_failure
      @error = params[:message]
      render_data_or_redirect('authFailure', error: @error)
    end
  
    protected
    def get_resource_from_auth_hash
      @resource = User.where({
        uid:      auth_hash['uid'],
        provider: auth_hash['provider'],
        full_name: auth_hash['info']['name'],
        image: auth_hash['info']['image']
      }).first_or_initialize
  
      if @resource.new_record?
        handle_new_resource
      end
  
      assign_provider_attrs(@resource, auth_hash)
  
      if assign_whitelisted_params?
        extra_params = whitelisted_params
        @resource.assign_attributes(extra_params) if extra_params
      end
  
      @resource
    end

    def resource_class(mapping = nil)
      if omniauth_params['resource_class']
        omniauth_params['resource_class'].constantize
      elsif params['resource_class']
        params['resource_class'].constantize
      else
        raise 'No resource_class found'
      end
    end
end