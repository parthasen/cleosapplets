ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    
    columns do
    
      column do
        panel "Recent Signups" do  
          table_for User.order("created_at desc").limit(50) do  
            column :username do |user|  
              link_to user.username, admin_user_path(user)  
            end
            column :email  
            column :created_at
          end  
          strong { link_to "View All Users", admin_users_path }  
        end   
      end

    end

  end
end