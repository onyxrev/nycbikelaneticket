Nycbikelaneticket::Application.routes.draw do
  root 'application#home'

  controller :plaintiffs, :path => "/plaintiffs" do
    get  "/"    => :index,  :as => :plaintiffs
    post "/"    => :create, :as => :create_plaintiff
    get  "/new" => :new,    :as => :new_plaintiff
  end

  controller :tickets, :path => "/tickets" do
    get  "/"    => :index,  :as => :tickets
    post "/"    => :create, :as => :create_ticket
    get  "/new" => :new,    :as => :new_ticket
  end

  controller :sessions, :path => "/sessions" do
    post "/"   => :create, :as => :create_session
    get "/new" => :new,    :as => :new_session
  end
end
