ActiveAdmin.register Defcon::AdminUser do

  menu :label => "AdminUsers"
  config.per_page = 50

  form do |f|
    f.semantic_errors # shows errors on :base
    #f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :id
      f.input :username
      f.input :password
      f.input :password_confirmation
      f.input :email
      f.input :read_only
      f.input :attempts
      f.input :max_attempts
      f.input :master
      f.input :updated_at
      f.input :created_at
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  controller do
    def create
      @admin_user = ::Defcon::AdminUser.new(admin_user_params)
      if @admin_user.save
        flash[:notice] = "Created Successfully!"
        redirect_to resource_path @admin_user
      else
        flash[:notice] = "#{@admin_user.errors.full_messages}"
        redirect_to new_resource_path @admin_user
        #super
        #render :new
      end
    end

    def update
      @admin_user = ::Defcon::AdminUser.find(params[:id])
      if @admin_user.update(admin_user_params)
        flash[:notice] = "Updated Successfully!"
        redirect_to resource_path @admin_user
      else
        flash.now[:notice] = "#{@admin_user.errors.full_messages}"
        render :edit
        #super
      end
    end

    def destroy
=begin
      @admin_user = ::Defcon::AdminUser.find(params[:id])
      @admin_user.destroy
      flash.now[:notice] = "Deleted Successfully!"
      render :index
=end
      flash.now[:notice] = "Deleting an Admin is serious business, update your policy first"
      render :index
    end

    private

      def admin_user_params
        params.require(:admin_user).permit(:username,:email,:password,:password_confirmation,:read_only,:attempts,:max_attempts,:master)
      end
  end

  index do
    column :id
    column :username
    column :email
    #column :password_digest
    #column :read_only
    column :attempts
    #column :max_attempts
    #column :master
    column :updated_at
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :username
      row :email
      row :password_digest
      row :read_only
      row :attempts
      row :max_attempts
      row :master
      row :updated_at
      row :created_at
    end
  end


end
