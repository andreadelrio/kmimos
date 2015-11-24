ActiveAdmin.register Booking do
  
  
  # == Schema Information
  #
  # Table name: bookings
  #
  #  id               :integer          not null, primary key
  #  start_date       :date
  #  end_date         :date
  #  provider_id      :integer
  #  user_first_name  :string(255)
  #  user_last_name   :string(255)
  #  user_phone       :string(255)
  #  user_email       :string(255)
  #  user_message     :string(255)
  #  created_at       :datetime
  #  updated_at       :datetime
  #  ref_code         :string(255)
  #  raza             :string(255)
  #  edad             :string(255)
  #  cuidado_especial :text
  #  token            :string(255)
  #  address          :string(255)
  #  pickup_time      :datetime
  #  dropoff_time     :datetime
  #  pet_name         :string(255)
  #
  
  permit_params :start_date, :end_date, :provider, :user_first_name, :user_last_name, :user_phone, 
  :user_mail, :user_message, :ref_code, :raza, :edad, :cuidado_especial, :address, :pet_name
  
   
  
  controller do 
    
    def destroy
      @provider = Provider.where(token: params[:id]).last
      @provider.destroy
      redirec_to action: :index
    end
  end
  
end