ActionController::Routing::Routes.draw do |map|
  map.resources :wikis, :collection => { :chatter => :get, :search => :get, :live_search => :post, :tagcloud => :get } do |wiki|
    wiki.resources :wiki_pages, :member => { :upload_handler => :post, :page_link_handler => :get, :delete_asset => :post,
      :un_edit => :post, :history => :get }
    wiki.show_by_title   ':title',    :controller => 'wiki_pages', :action => 'show_by_title'
    wiki.tag       'tag/:tag_name',   :controller => 'wikis', :action => 'list_by_tag'
    wiki.tag_index 'tag_index',       :controller => 'wikis', :action => 'tag_index'
  end


  map.connect 'themes/:action', :controller => 'themes'
  map.connect 'themes/:action/:name.:format', :controller => 'themes'
  
  map.resources :site_settings, :collection => { :update_site_settings => :post, :admin => :get }

  map.resources :content_pages, :member => { :upload_handler => :post, :delete_asset => :post,
    :un_edit => :post }, :collection => { :search => :get }

  map.resources :categories

  map.resources :wiki_comments, :collection => { :daily => :get, :weekly => :get }
  
#  map.with_options :controller => 'wiki_pages', :name_prefix => 'wiki_page_', :path_prefix => '/wiki' do |wiki_page|
#    wiki_page.show_home '',                 :action => 'show_by_title', :title => 'Home'
#    wiki_page.homepage  'homepage',         :action => 'homepage'
#    wiki_page.chatter   'chatter',          :action => 'chatter'
#    wiki_page.edit      'edit/:id',         :action => 'edit'
#    wiki_page.new       'new',              :action => 'new'
#    wiki_page.index     'index',            :action => 'index'
#    wiki_page.tag       'tag/:tag_name',    :action => 'list_by_tag'
#    wiki_page.tag_index 'tag_index',        :action => 'tag_index'
#    wiki_page.history   'history/:title',   :action => 'history'
#    wiki_page.search    'search',           :action => 'search'
#    wiki_page.live_search  'live_search',   :action => 'live_search'
#    wiki_page.tagcloud  'tagcloud',         :action => 'tagcloud'
#    wiki_page.show      ':title',           :action => 'show_by_title'
#  end

  map.connect '/tagcloud.:format', :controller => 'wiki_pages', :action => 'tagcloud'


  map.resources :forums do |forum|
    forum.resources :message_posts, :collection => { :search => :get }
  end

  map.resource :account, :controller => "users"
  map.resources :users, :collection => { :reg_pass_required => :get }
  map.resources :user_groups, :member => { :drop_user => :post, :add_members => :get, :add_users => :post }
  map.resource :user_session
  map.register '/register', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'user_sessions', :action => "new"
  map.root :controller => 'content_pages', :action => 'home'
end
