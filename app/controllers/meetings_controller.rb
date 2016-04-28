class MeetingsController < ApplicationController
	before_action :set_meeting, only: [:show]
    before_action :authenticate_user! 

	def new
		session[:chosen_provider_id] = params[:provider_id]
    
	  @meeting = Meeting.new
    @meeting.user_email = current_user.email rescue ""
    @meeting.user_first_name = current_user.first_name rescue ""
    @meeting.user_last_name = current_user.last_name rescue ""
    @meeting.user_phone = current_user.phone rescue ""
     @meeting.provider_id = params[:provider_id]
	end

	def show
	end

	def create 
		@meeting = Meeting.new(meeting_params)
    
    @meeting.user = current_user
    
	  if @meeting.save
    	MeetingConfirmationMailer.new_meeting_notification(@meeting, current_country).deliver
    	MeetingConfirmationMailer.new_meeting_provider_notification(@meeting, current_country).deliver
    	MeetingConfirmationMailer.new_meeting_for_admin(@meeting, current_country).deliver

      
	    session[:start_date] = nil
	    session[:end_date] = nil
      	session[:user_email] = nil
	    redirect_to  meeting_path(@meeting)
	  else
	    render 'new'
	  end
	end

	def send_mail
	    @provider = Provider.find(params[:provider_id])
	    @meeting = Meeting.find(params[:meeting_id])

	    MeetingConfirmationMailer.new_meeting_notification(@meeting, current_country).deliver
    	MeetingConfirmationMailer.new_meeting_provider_notification(@meeting, current_country).deliver
    	MeetingConfirmationMailer.new_meeting_for_admin(@meeting, current_country).deliver

	    render :text => "Correo enviado a " + @provider.name + "(" + @provider.id.to_s + ") con el meeting " + @meeting.id.to_s + "."
	  end  


	private

	def meeting_params
	  params.require(:meeting).permit! #(:user_first_name, :user_last_name, :provider_id, :user_phone, :user_email)
	end

	def set_meeting
    @meeting = Meeting.find_by_token(params[:id])
  	end

	def get_dates
	  unless params[:start_date].nil? || params[:start_date].empty?
	    session[:start_date] = Date.strptime(params[:start_date],'%d/%m/%Y')
	  end
	  unless params[:start_date].nil? || params[:start_date].empty?
	    session[:end_date] = Date.strptime(params[:end_date],'%d/%m/%Y')
	  end
	end

end