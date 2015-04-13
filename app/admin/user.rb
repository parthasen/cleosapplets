ActiveAdmin.register User do
	permit_params :username, :email, :password, :password_confirmation, :fb_user_id

	config.per_page = 50

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :id
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :fb_user_id
      f.input :updated_at
      f.input :created_at
    end
    f.actions
  end

end