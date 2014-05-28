AppleCidr::Application.routes.draw do
   root 'addresses#lookup'

   resources :addresses do
     collection do
       get 'lookup'
     end
   end
end
