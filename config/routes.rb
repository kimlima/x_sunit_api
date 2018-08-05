Rails.application.routes.draw do
  #Api definintion
  namespace 'api' do
    namespace 'v1' do
      resources :survivors do
        resources :localization
        resources :witnesses
      end
      get 'reports/abducted_percentage'
      get 'reports/non_abducted_percentage'
      get 'reports/list'
    end
  end
end
