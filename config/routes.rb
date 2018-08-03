Rails.application.routes.draw do
  #Api definintion
  namespace 'api' do
    namespace 'v1' do
      resources :survivors do
        resources :localization
        resources :witnesses
      end
    end
  end
end
