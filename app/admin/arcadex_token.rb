ActiveAdmin.register Arcadex::Token do

  menu :label => "Tokens"
  config.per_page = 50

=begin
  batch_action :flag do |selection|
    Arcadex::Token.find(selection).each { |p| p.flag! }
    redirect_to collection_path, :notice => "Tokens flagged!"
  end
=end

  form do |f|
    f.semantic_errors # shows errors on :base
    #f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :id
      f.input :imageable_id
      f.input :imageable_type
      f.input :times_used
      f.input :first_ip_address
      f.input :current_ip_address
      f.input :auth_token
      f.input :expiration_minutes
      f.input :updated_at
      f.input :created_at
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  controller do
    def create
      @token = ::Arcadex::Token.new(token_params)
      if @token.save
        flash[:notice] = "Created Successfully!"
        redirect_to resource_path @token
      else
        flash[:notice] = "#{@token.errors.full_messages}"
        redirect_to new_resource_path @token
        #super
        #render :new
      end
    end

    def update
      @token = ::Arcadex::Token.find(params[:id])
      if @token.update(token_params)
        flash[:notice] = "Updated Successfully!"
        redirect_to resource_path @token
      else
        flash.now[:notice] = "#{@token.errors.full_messages}"
        render :edit
        #super
      end
    end

    def destroy
      @token = ::Arcadex::Token.find(params[:id])
      @token.destroy
      flash.now[:notice] = "Deleted Successfully!"
      render :index
    end

    private

      def token_params
        params.require(:token).permit(:times_used,:imageable_id,:imageable_type,:password_confirmation,:first_ip_address,:current_ip_address,:auth_token,:expiration_minutes)
      end
  end

  index do
    selectable_column
    column :id
    column :imageable_id
    column :imageable_type
    column :times_used
    column :first_ip_address
    column :current_ip_address
    column :auth_token
    column :expiration_minutes
    column :updated_at
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :imageable_id
      row :imageable_type
      row :times_used
      row :first_ip_address
      row :current_ip_address
      row :auth_token
      row :expiration_minutes
      row :updated_at
      row :created_at
    end
  end


end
