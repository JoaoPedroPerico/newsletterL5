class EmailsController < ApplicationController
  def index
    @emails = Email.all
  end

  def new
    @email = Email.new
    @templates = Template.all
  end

  def show
    @email = Email.find(params[:id])
  end

  def create
    
    @email = Email.new()
    @email.subject = email_params[:subject]
    @email.body = email_params[:body]
    @template = Template.find_by_id(email_params[:template])

    if @template.present?
      @email.body = @template.body.gsub("{{-placeholder-}}", @email.body)
    end

    if @email.save
      Subscriber.all.each do |subscriber|
        NewsletterMailer.email(subscriber, @email).deliver_now
      end
      redirect_to emails_path, notice: "Email sent"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def email_params
      params.require(:email).permit(:subject, :body, :template)
    end
end